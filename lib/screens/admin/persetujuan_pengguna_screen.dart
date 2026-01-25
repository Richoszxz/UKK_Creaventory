import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:google_fonts/google_fonts.dart';

class PersetujuanPenggunaScreen extends StatefulWidget {
  const PersetujuanPenggunaScreen({super.key});

  @override
  State<PersetujuanPenggunaScreen> createState() =>
      _PersetujuanPenggunaScreenState();
}

class _PersetujuanPenggunaScreenState extends State<PersetujuanPenggunaScreen> {
  List<Map<String, String>> daftarPengguna = [
    {"nama": "Richo Ferdinand", "email": "richoferdinand@gmail.com"},
    {"nama": "Richa Ferdinyoy", "email": "richaferdinyoy@gmail.com"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        judulAppBar: "Persetujuan\nPengguna",
        tombolKembali: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: daftarPengguna
            .map(
              (pengguna) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      title: Text(
                        daftarPengguna[0]['nama'] ?? '',
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        daftarPengguna[0]['email'] ?? '',
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 20,
                        ),
                      )
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
