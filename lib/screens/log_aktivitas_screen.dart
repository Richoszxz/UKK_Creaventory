import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class LogAktivitasScreen extends StatefulWidget {
  const LogAktivitasScreen({super.key});

  @override
  State<LogAktivitasScreen> createState() => _LogAktivitasScreenState();
}

class _LogAktivitasScreenState extends State<LogAktivitasScreen> {
  // Data Dummy Log Aktivitas
  final List<Map<String, dynamic>> logData = [
    {
      "judul": "Peminjaman Baru",
      "deskripsi": "Richo Ferdinand meminjam iPad M3 Pro",
      "waktu": "10 Menit yang lalu",
      "icon": Icons.add_shopping_cart,
      "tipe": "tambah",
    },
    {
      "judul": "Pengembalian Alat",
      "deskripsi": "Gema AI mengembalikan Kamera DSLR",
      "waktu": "2 Jam yang lalu",
      "icon": Icons.assignment_turned_in_outlined,
      "tipe": "kembali",
    },
    {
      "judul": "Update Stok",
      "deskripsi": "Admin mengubah stok MacBook Air",
      "waktu": "5 Jam yang lalu",
      "icon": Icons.edit_note,
      "tipe": "edit",
    },
    {
      "judul": "User Baru",
      "deskripsi": "Richa Ferdinyoy mendaftar sebagai Peminjam",
      "waktu": "Kemarin",
      "icon": Icons.person_add_alt_1,
      "tipe": "user",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(judulAppBar: "Log\nAktivitas"),
      drawer: const NavigationDrawerWidget(),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: logData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final item = logData[index];
          return _buildLogTile(item);
        },
      ),
    );
  }

  Widget _buildLogTile(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        border: BoxBorder.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        title: Text(
          item['judul'],
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['deskripsi'],
              maxLines: 1,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              item['waktu'],
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        // ICON DI KANAN DENGAN KOTAK DI BELAKANGNYA
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary, // Warna Kotak
            borderRadius: BorderRadius.circular(10),
            border: BoxBorder.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1
            )
          ),
          child: Icon(
            item['icon'],
            color: Theme.of(context).colorScheme.onSecondary, // Warna Ikon
            size: 24,
          ),
        ),
      ),
    );
  }
}
