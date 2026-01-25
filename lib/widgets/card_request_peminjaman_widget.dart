import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardRequestPeminjamanWidget extends StatelessWidget {
  final String? kodePeminjaman;
  final String? namaPeminjam;
  final String? daftarBarang;
  final VoidCallback? disetujui;
  final VoidCallback? ditolak;

  const CardRequestPeminjamanWidget({
    super.key,
    this.kodePeminjaman,
    this.namaPeminjam,
    this.daftarBarang,
    this.disetujui,
    this.ditolak,
  });

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;
    final onSecondary = Theme.of(context).colorScheme.onSecondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= KODE =================
            Text(
              kodePeminjaman ?? '',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: onSecondary,
              ),
            ),

            // ================= NAMA =================
            Text(
              namaPeminjam ?? '',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: onSecondary,
              ),
            ),

            // ================= BARANG =================
            Text(
              daftarBarang ?? '',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: onSecondary.withOpacity(0.9),
              ),
            ),

            SizedBox(height: 10),

            // ================= BUTTON =================
            Row(
              children: [
                // TOLAK
                Expanded(
                  child: OutlinedButton(
                    onPressed: ditolak,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: onSecondary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      "Tolak",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: onSecondary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // SETUJU
                Expanded(
                  child: ElevatedButton(
                    onPressed: disetujui,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onSecondary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      "Setuju",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
