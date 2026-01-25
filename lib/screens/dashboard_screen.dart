import 'package:flutter/material.dart';
import '../widgets/card_request_peminjaman_widget.dart';
import 'package:creaventory/export.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> requests = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "barang": "1 Tablet iPad, 1 Stylus Pen",
    },
    {
      "kode": "TRX24578966",
      "nama": "Richa Ferdinyoy",
      "barang": "1 Kamera DSLR",
    },
  ];

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
                "10",
                Theme.of(context).colorScheme.secondary,
              ),
              buildDashboardCard(
                context,
                "Jumlah Alat",
                "10",
                Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDashboardCard(
                context,
                "Alat Dipinjam",
                "10",
                Theme.of(context).colorScheme.secondary,
              ),
              buildDashboardCard(
                context,
                "Alat Tersedia",
                "10",
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
                      "Laporan Peminjaman",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
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
                    onPressed: () {},
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

          const SizedBox(height: 15),

          // ===================== PEMINJAMAN TERBARU =====================
          Text(
            "Peminjaman Terbaru:",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
            ),
          ),

          const SizedBox(height: 10),

          ...requests.map((request) {
            return CardRequestPeminjamanWidget(
              kodePeminjaman: request['kode'],
              namaPeminjam: request['nama'],
              daftarBarang: request['barang'],
              disetujui: () {},
              ditolak: () {},
            );
          }).toList(),

          const SizedBox(height: 30),
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
    height: 150,
    width: 175,
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
