import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int penggunaAktif = 0;
  int jumlahAlat = 0;
  int alatDipinjam = 0;
  int alatTersedia = 0;
  bool isLoading = true;

  Future<void> loadDashboard() async {
    try {
      final client = SupabaseService.client;

      /// 1️⃣ Pengguna aktif
      final pengguna = await client
          .from('pengguna')
          .select('id_user')
          .eq('status', true);

      /// 2️⃣ Total alat + total stok
      final alat = await client.from('alat').select('id_alat, stok_alat');

      int totalStok = 0;
      for (final item in alat) {
        totalStok += (item['stok_alat'] as int);
      }

      /// 3️⃣ Alat sedang dipinjam
      final dipinjam = await client
          .from('detail_peminjaman')
          .select('jumlah_peminjaman, peminjaman!inner(status_peminjaman)')
          .inFilter('peminjaman.status_peminjaman', ['menunggu', 'dipinjam']);

      int totalDipinjam = 0;
      for (final item in dipinjam) {
        totalDipinjam += (item['jumlah_peminjaman'] as int);
      }

      setState(() {
        penggunaAktif = pengguna.length;
        jumlahAlat = alat.length;
        alatDipinjam = totalDipinjam;
        alatTersedia = totalStok - totalDipinjam;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Gagal load dashboard: $e");
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<List<dynamic>> fetchLaporanHariIni() async {
    final client = SupabaseService.client;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final data = await client
        .from('peminjaman')
        .select('''
        kode_peminjaman,
        tanggal_peminjaman,
        tanggal_kembali_rencana,
        status_peminjaman,

        pengguna:pengguna!peminjaman_id_user_fkey (
          username,
          email
        ),

        detail_peminjaman (
          jumlah_peminjaman,
          alat (
            nama_alat,
            kondisi_alat
          )
        )
      ''')
        .inFilter('status_peminjaman', ['dipinjam', 'dikembalikan'])
        .gte('tanggal_peminjaman', '$today 00:00:00')
        .lte('tanggal_peminjaman', '$today 23:59:59')
        .order('tanggal_peminjaman', ascending: false);

    return data;
  }

  Future<void> cetakLaporan() async {
    final data = await fetchLaporanHariIni();

    final pdf = pw.Document();
    final font = await PdfGoogleFonts.poppinsRegular();
    final bold = await PdfGoogleFonts.poppinsBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(
            'LAPORAN PEMINJAMAN & PENGEMBALIAN HARI INI',
            style: pw.TextStyle(font: bold, fontSize: 18),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Tanggal: ${DateTime.now().toString().substring(0, 10)}',
            style: pw.TextStyle(font: font),
          ),
          pw.SizedBox(height: 15),

          pw.Table.fromTextArray(
            headers: [
              'Kode',
              'Email',
              'Username',
              'Tanggal Pinjam',
              'Tanggal Kembali',
              'Status',
              'Alat',
              'Jumlah',
            ],
            headerStyle: pw.TextStyle(font: bold, fontSize: 6),
            cellStyle: pw.TextStyle(font: font, fontSize: 6),
            cellPadding: const pw.EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 2,
            ),
            columnWidths: {
              0: const pw.FlexColumnWidth(1.4), // kode
              1: const pw.FlexColumnWidth(2.2), // email
              2: const pw.FlexColumnWidth(1.5), // user
              3: const pw.FlexColumnWidth(1.3), // pinjam
              4: const pw.FlexColumnWidth(1.3), // kembali
              5: const pw.FlexColumnWidth(1.1), // status
              6: const pw.FlexColumnWidth(2.0), // alat
              7: const pw.FlexColumnWidth(0.8), // qty
            },
            data: data.expand((p) {
              return (p['detail_peminjaman'] as List).map((dp) {
                return [
                  p['kode_peminjaman'],
                  p['pengguna']['email'],
                  p['pengguna']['username'],
                  p['tanggal_peminjaman'].toString().substring(0, 10),
                  p['tanggal_kembali_rencana'].toString().substring(0, 10),
                  p['status_peminjaman'],
                  dp['alat']['nama_alat'],
                  dp['jumlah_peminjaman'].toString(),
                ];
              }).toList();
            }).toList(),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Dashboard"),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // ===================== DASHBOARD CARD =====================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDashboardCard(
                context,
                "Pengguna Aktif",
                isLoading ? "-" : penggunaAktif.toString(),
                Theme.of(context).colorScheme.secondary,
              ),
              buildDashboardCard(
                context,
                "Jumlah Alat",
                isLoading ? "-" : jumlahAlat.toString(),
                Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDashboardCard(
                context,
                "Alat Dipinjam",
                isLoading ? "-" : alatDipinjam.toString(),
                Theme.of(context).colorScheme.secondary,
              ),
              buildDashboardCard(
                context,
                "Alat Tersedia",
                isLoading ? "-" : alatTersedia.toString(),
                Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ===================== CETAK LAPORAN =====================
          Text(
            "Cetak Laporan:",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 5,
            ),
            width: double.infinity,
            height: 135,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.insert_drive_file_outlined,
                        size: 35,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "Laporan Peminjaman dan\nPengembalian Hari Ini",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await cetakLaporan();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.print_outlined,
                          size: 24,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Cetak",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildDashboardCard(
  BuildContext context,
  String title,
  String count,
  Color color,
) {
  return Container(
    margin: EdgeInsets.all(5),
    height: MediaQuery.of(context).size.height * 0.20,
    width: MediaQuery.of(context).size.width * 0.43,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}
