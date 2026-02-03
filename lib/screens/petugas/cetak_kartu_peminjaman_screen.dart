import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:printing/printing.dart';
import 'package:creaventory/services/cetak_kartu_peminjaman_service.dart';

class CetakKartuPeminjamanScreen extends StatefulWidget {
  final ModelPeminjaman dataPeminjaman;
  const CetakKartuPeminjamanScreen({super.key, required this.dataPeminjaman});

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
                      widget.dataPeminjaman.kodePeminjaman!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Nama Peminjam",
                    value: Text(
                      widget.dataPeminjaman.namaUser!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Email Peminjam",
                    value: Text(
                      widget.dataPeminjaman.emailUser ?? "-",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Tanggal Peminjaman",
                    value: Text(
                      widget.dataPeminjaman.tanggalPeminjaman.toString().split(
                        " ",
                      )[0],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  rowDetail(
                    label: "Rencana Pengembalian",
                    value: Text(
                      widget.dataPeminjaman.tanggalKembaliRencana
                          .toString()
                          .split(" ")[0],
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
                      children: widget.dataPeminjaman.detailPeminjaman
                          .map(
                            (item) => Text(
                              "x${item.jumlahPeminjaman} ${item.namaAlat}",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                          .toList(),
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
                onPressed: () async {
                  final pdfData = await CetakKartuPeminjamanService.generate(
                    kodePeminjaman: widget.dataPeminjaman.kodePeminjaman!,
                    namaPeminjam: widget.dataPeminjaman.namaUser!,
                    email: widget.dataPeminjaman.emailUser ?? "",
                    tanggalPinjam: widget.dataPeminjaman.tanggalPeminjaman,
                    tanggalKembali:
                        widget.dataPeminjaman.tanggalKembaliRencana,
                    daftarAlat: widget.dataPeminjaman.detailPeminjaman
                        .map((e) => "x${e.jumlahPeminjaman} ${e.namaAlat}")
                        .toList(),
                  );

                  await Printing.layoutPdf(onLayout: (_) async => pdfData);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.picture_as_pdf_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Cetak Kartu",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
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
