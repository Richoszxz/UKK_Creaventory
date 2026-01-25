import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class CetakKartuPeminjamanScreen extends StatefulWidget {
  const CetakKartuPeminjamanScreen({super.key});

  @override
  State<CetakKartuPeminjamanScreen> createState() =>
      _CetakKartuPeminjamanScreenState();
}

class _CetakKartuPeminjamanScreenState
    extends State<CetakKartuPeminjamanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        judulAppBar: "Kartu\nPeminjaman",
        tombolKembali: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: BoxBorder.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_splash_screen.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "SMKS BRANTAS KARANGKATES",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "KARTU PEMINJAMAN",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  rowDetail(
                    label: "Kode Peminjaman",
                    value: Text(
                      "TRX24578965",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Nama Peminjam",
                    value: Text(
                      "Richo Ferdinand",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Email Peminjam",
                    value: Text(
                      "richoferdinand@gmail.com",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Tanggal Peminjaman",
                    value: Text(
                      "18 Jan 2026",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Rencana Pengembalian",
                    value: Text(
                      "19 Jan 2026",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Alat yang dipinjam",
                    value: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1 iPad Pro M3",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          "1 Stylus Pen",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Simpan",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowDetail({required String label, required Widget value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// LABEL
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          /// TITIK DUA
          Text(
            " :  ",
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          /// VALUE
          Expanded(child: value),
        ],
      ),
    );
  }
}
