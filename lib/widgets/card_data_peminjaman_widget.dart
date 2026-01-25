import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDataPeminjamanWidget extends StatelessWidget {
  final String kode;
  final String nama;
  final String tglPinjam;
  final String tglRencanaKembali;
  final VoidCallback? onDetail;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CardDataPeminjamanWidget({
    super.key,
    required this.kode,
    required this.nama,
    required this.tglPinjam,
    required this.tglRencanaKembali,
    this.onDetail,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Kode
          Text(
            kode,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),

          /// Nama
          Text(
            nama,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),

          /// Tanggal
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 14,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Waktu peminjaman: $tglPinjam",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(
                Icons.event_available,
                size: 14,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Rencana pengembalian: $tglRencanaKembali",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          /// Tombol Aksi
          Row(
            children: [
              /// DETAIL (ambil space besar)
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onDetail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Detail",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              /// EDIT
              Expanded(
                child: _IconButton(icon: Icons.edit, onTap: onEdit),
              ),
              const SizedBox(width: 8),

              /// DELETE
              Expanded(
                child: _IconButton(icon: Icons.delete, onTap: onDelete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// tombol kecil icon reusable
class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
