import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class TambahDataPengembalianScreen extends StatefulWidget {
  const TambahDataPengembalianScreen({super.key});

  @override
  State<TambahDataPengembalianScreen> createState() =>
      _TambahDataPengembalianScreenState();
}

class _TambahDataPengembalianScreenState
    extends State<TambahDataPengembalianScreen> {
      
  // --- STATE ---
  String? selectedKode;
  DateTime? tglKembali;
  // Contoh data dummy alat yang terikat dengan Kode Peminjaman
  final List<Map<String, dynamic>> daftarAlatDummy = [
    {"nama": "iPad M3 Pro", "qty": "1"},
    {"nama": "Stylus Pen", "qty": "1"},
  ];
  // Map untuk menyimpan kondisi masing-masing alat
  Map<String, String> kondisiAlat = {
    "iPad M3 Pro": "Baik",
    "Stylus Pen": "Baik",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        judulAppBar: "Tambah\nPengembalian",
        tombolKembali: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. KODE PEMINJAMAN
            _buildLabel("Kode peminjaman:"),
            _buildDropdownKodePeminjaman(),
            const SizedBox(height: 20),

            // 2. TANGGAL PENGEMBALIAN
            _tanggalField(
              label: "Tanggal pengembalian:",
              selectedDate: tglKembali,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 20),

            // 3. DAFTAR ALAT (Muncul berdasarkan kode yang dipilih)
            _buildLabel("Daftar alat:"),
            Column(
              children: daftarAlatDummy.map((item) {
                return _buildItemCard(item['nama'], item['qty']);
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 4. RINGKASAN DENDA
            _buildLabel("Ringkasan Denda:"),
            _buildDendaCard(0, 0, 0, 0), // Default value dummy

            const SizedBox(height: 40),
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
                "Buat Pengembalian",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildDropdownKodePeminjaman() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _fieldDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedKode,
          hint: Text(
            "Pilih Kode Peminjaman",
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
          ),
          isExpanded: true,
          items: [
            "TRX24578965",
            "TRX45672905",
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => selectedKode = v),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(
        (tglKembali = picked) as VoidCallback,
      );
    }
  }

  Widget _tanggalField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: _fieldDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  selectedDate == null
                      ? "dd/mm/yyyy"
                      : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownKondisi(String namaAlat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 25,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: kondisiAlat[namaAlat],
          dropdownColor: Theme.of(context).colorScheme.primary,
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

  Widget _buildItemCard(String namaAlat, String qty) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
              color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
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

  Widget _dendaText(String label, String val, {bool isBold = false}) => Text(
    "$label $val",
    style: GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 13,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    ),
  );

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
        color: Theme.of(context).colorScheme.secondary,
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
}
