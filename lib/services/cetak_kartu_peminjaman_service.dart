import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:creaventory/export.dart';

class CetakKartuPeminjamanService {
  static Future<Uint8List> generate({
    required String kodePeminjaman,
    required String namaPeminjam,
    required String email,
    required DateTime tanggalPinjam,
    required DateTime tanggalKembali,
    required List<String> daftarAlat,
  }) async {
    final pdf = pw.Document();

    final green = PdfColor.fromHex('#248250');

    final ByteData imageData = await rootBundle.load(
      'assets/images/logo_splash_screen.png',
    );

    final Uint8List imageBytes = imageData.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: green, width: 1),
                borderRadius: pw.BorderRadius.circular(20),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(pw.MemoryImage(imageBytes), width: 80, height: 80),
                  pw.Text(
                    "Creaventory",
                    style: pw.TextStyle(
                      fontSize: 20,
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    "SMKS BRANTAS KARANGKATES",
                    style: pw.TextStyle(
                      fontSize: 20,
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    "KARTU PEMINJAMAN",
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),

                  pw.SizedBox(height: 20),

                  _row("Kode Peminjaman", kodePeminjaman, green),
                  _row("Nama Peminjam", namaPeminjam, green),
                  _row("Email Peminjam", email.isEmpty ? "-" : email, green),
                  _row("Tanggal Peminjaman", _fmt(tanggalPinjam), green),
                  _row("Rencana Pengembalian", _fmt(tanggalKembali), green),

                  pw.SizedBox(height: 10),

                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      "Alat yang dipinjam :",
                      style: pw.TextStyle(
                        fontSize: 16,
                        color: green,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  ...daftarAlat.map(
                    (e) => pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        e,
                        style: pw.TextStyle(fontSize: 16, color: green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _row(String label, String value, PdfColor color) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontSize: 16, color: color),
            ),
          ),
          pw.Text(" : "),
          pw.Expanded(
            flex: 6,
            child: pw.Text(
              value,
              style: pw.TextStyle(fontSize: 16, color: color),
            ),
          ),
        ],
      ),
    );
  }

  static String _fmt(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
}
