import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class KonfirmasiPengembalianScreen extends StatefulWidget {
  final Map<String, dynamic> dataPengembalian;

  const KonfirmasiPengembalianScreen({
    super.key,
    required this.dataPengembalian,
  });

  @override
  State<KonfirmasiPengembalianScreen> createState() =>
      _KonfirmasiPengembalianScreenState();
}

class _KonfirmasiPengembalianScreenState
    extends State<KonfirmasiPengembalianScreen> {
  final Color darkGreen = const Color(0xFF2D8154);
  final Color lightGreenBg = const Color(0xFFD4E7D7);
  final Color statusRed = const Color(0xFF822424);

  // Map untuk menyimpan kondisi masing-masing alat (Key: Nama Alat)
  late Map<String, String> kondisiAlat;

  // Variabel harga denda per unit rusak
  final int hargaDendaRusak = 50000;

  @override
  void initState() {
    super.initState();
    // Inisialisasi kondisi awal dari list 'alat'
    List alatList = widget.dataPengembalian['barang'] ?? [];
    kondisiAlat = {for (var item in alatList) item['nama']: "Baik"};
  }

  // --- LOGIKA HITUNG DENDA ---
  int _hitungDendaKerusakan() {
    int total = 0;
    List alatList = widget.dataPengembalian['barang'] ?? [];

    for (var item in alatList) {
      if (kondisiAlat[item['nama']] == "Rusak") {
        // Denda = jumlah barang (qty) * harga denda rusak
        total += (item['qty'] as int) * hargaDendaRusak;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final bool isTerlambat = widget.dataPengembalian['terlambat'] ?? false;
    final List alatList = widget.dataPengembalian['barang'] ?? [];

    int hariTerlambat = isTerlambat ? 2 : 0;
    int dendaTerlambat = hariTerlambat * 5000;
    int dendaKerusakan = _hitungDendaKerusakan();
    int totalDenda = dendaTerlambat + dendaKerusakan;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        judulAppBar: "Konfirmasi\nPengembalian",
        tombolKembali: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Kode Peminjaman"),
            _buildTextField(widget.dataPengembalian['kode'] ?? "-"),

            const SizedBox(height: 15),
            _buildLabel("Data Peminjam"),
            _buildDataPeminjamCard(isTerlambat),

            const SizedBox(height: 15),
            _buildLabel("Daftar alat"),

            // LOOPING BERDASARKAN STRUKTUR DATA BARU
            ...alatList
                .map(
                  (item) => _buildItemCard(
                    item['nama'].toString(),
                    item['qty'].toString(),
                  ),
                )
                .toList(),

            const SizedBox(height: 15),
            _buildLabel("Ringkasan Denda"),
            _buildDendaCard(
              hariTerlambat,
              dendaTerlambat,
              dendaKerusakan,
              totalDenda,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                isTerlambat
                    ? "Konfirmasi Pengembalian Terlambat"
                    : "Konfirmasi Pengembalian",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- KOMPONEN UI ---

  Widget _buildItemCard(String namaAlat, String qty) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lightGreenBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: darkGreen,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$namaAlat (x$qty)",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Kondisi alat: ",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    const SizedBox(width: 5),
                    _buildDropdownKondisi(namaAlat),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownKondisi(String namaAlat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 25,
      decoration: BoxDecoration(
        color: darkGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: kondisiAlat[namaAlat],
          dropdownColor: darkGreen,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 16,
          ),
          items: ["Baik", "Rusak"]
              .map(
                (val) => DropdownMenuItem(
                  value: val,
                  child: Text(
                    val,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              )
              .toList(),
          onChanged: (newVal) =>
              setState(() => kondisiAlat[namaAlat] = newVal!),
        ),
      ),
    );
  }

  // --- WIDGET LAINNYA ---

  Widget _buildDataPeminjamCard(bool isTerlambat) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lightGreenBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: darkGreen),
      ),
      child: Column(
        children: [
          _infoRow(
            Icons.person,
            "Nama:",
            widget.dataPengembalian['nama'] ?? "-",
          ),
          _infoRow(Icons.mail, "Email:", widget.dataPengembalian['email']),
          _infoRow(
            Icons.calendar_month,
            "Tanggal pinjam:",
            widget.dataPengembalian['tglPinjam'] ?? "-",
          ),
          _infoRow(
            Icons.calendar_month,
            "Rencana pengembalian:",
            widget.dataPengembalian['tglRencanaPengembalian'],
          ),
          _infoRow(
            Icons.event_available,
            "Tanggal pengembalian:",
            widget.dataPengembalian['tglPengembalian'] ?? "-",
          ),
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: darkGreen),
              const SizedBox(width: 8),
              Text(
                "Status: ",
                style: GoogleFonts.poppins(fontSize: 14, color: darkGreen),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isTerlambat ? statusRed : darkGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isTerlambat ? "Terlambat" : "Tepat Waktu",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDendaCard(
    int hari,
    int dendaterlambat,
    int dendaKerusakan,
    int totalDenda,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lightGreenBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dendaText("Terlambat (hari):", "$hari Hari"),
          _dendaText("Denda Terlambat:", "Rp. $dendaterlambat"),
          _dendaText("Denda Kerusakan:", "Rp. $dendaKerusakan"),
          const Divider(color: Colors.black12),
          _dendaText("Total Denda:", "Rp. $totalDenda", isBold: true),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 5, left: 4),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: const Color(0xFF424242),
      ),
    ),
  );

  Widget _buildTextField(String val) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    decoration: BoxDecoration(
      color: lightGreenBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: darkGreen),
    ),
    child: Text(
      val,
      style: GoogleFonts.poppins(
        color: darkGreen,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _infoRow(IconData icon, String label, String val) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSecondary),
        const SizedBox(width: 8),
        Text(
          "$label $val",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    ),
  );

  Widget _dendaText(String label, String val, {bool isBold = false}) => Text(
    "$label $val",
    style: GoogleFonts.poppins(
      color: darkGreen,
      fontSize: 13,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
