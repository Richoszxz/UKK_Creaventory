import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/card_list_widget.dart';

class ManajemenPenggunaScreen extends StatefulWidget {
  const ManajemenPenggunaScreen({super.key});

  @override
  State<ManajemenPenggunaScreen> createState() => _ManajemenPenggunaScreenState();
}

class _ManajemenPenggunaScreenState extends State<ManajemenPenggunaScreen> {
  List<Map<String, String>> daftarPengguna = [
    {"nama": "Richo Ferdinand", "email": "richoferdinand@gmail.com"},
    {"nama": "Richa Ferdinyoy", "email": "richaferdinyoy@gmail.com"},
  ];

  int jumlahRequest = 2; // contoh: ada 2 request pending

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Manajemen\nPengguna"),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          BarPencarianWidget(hintText: 'Cari pengguna...'),
          ListView(
            shrinkWrap: true,
            children: daftarPengguna
                .map(
                  (pengguna) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 7,
                    ),
                    child: CardListWidget(
                      title: pengguna['nama'],
                      subtitle: pengguna['email'],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed('/persetujuan_pengguna'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.group_add_outlined),
            shape: CircleBorder(),
          ),

          // Badge notifikasi
          if (jumlahRequest > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    jumlahRequest.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
