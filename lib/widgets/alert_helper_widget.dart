import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertHelper {
  // =======================
  // ALERT SUKSES
  // =======================
  static void showSuccess(
    BuildContext context,
    String message, {
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text("Berhasil", style: GoogleFonts.poppins()),
          content: Text(message, style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // ✅ tutup dialog aman
                onOk?.call();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // =======================
  // ALERT ERROR
  // =======================
  static void showError(
    BuildContext context,
    String message, {
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text("Terjadi Kesalahan", style: GoogleFonts.poppins()),
          content: Text(message, style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // ✅ aman
                onOk?.call();
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  // =======================
  // ALERT KONFIRMASI
  // =======================
  static void showConfirm(
    BuildContext context, {
    required String judul,
    required String pesan,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(judul, style: GoogleFonts.poppins()),
          content: Text(pesan, style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // tutup dialog
              },
              child: Text(
                "Batal",
                style: GoogleFonts.poppins(color: Color(0xFF424242)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // tutup dialog
                onConfirm(); // jalankan aksi
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }
}
