import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardListRiwayatPeminjamanWidget extends StatelessWidget {
  final String kodePeminjaman;
  final String namaPeminjam;
  final String tanggalPinjam;
  final String tanggalRencanaKembali;
  final String listAlatDipinjam;
  final VoidCallback? aksiPengajuanPengembalian;
  const CardListRiwayatPeminjamanWidget({
    super.key,
    required this.kodePeminjaman,
    required this.namaPeminjam,
    required this.tanggalPinjam,
    required this.tanggalRencanaKembali,
    required this.listAlatDipinjam,
    this.aksiPengajuanPengembalian,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kodePeminjaman,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Text(
                tanggalPinjam,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),

          /// Nama
          Text(
            namaPeminjam,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),

          Text(
            listAlatDipinjam,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
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
                  "Rencana pengembalian: $tanggalRencanaKembali",
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
          Container(
            width: double.infinity,
            height: 35,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: aksiPengajuanPengembalian,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Pengajuan Pengembalian",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
