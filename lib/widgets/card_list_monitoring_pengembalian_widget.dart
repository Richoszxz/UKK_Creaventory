import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardListMonitoringPengembalianWidget extends StatelessWidget {
  final String kodePeminjaman;
  final String namaPeminjam;
  final String tanggalPinjam;
  final String tanggalPengembalian;
  final String listAlatDikembalikan;
  final bool terlambat;
  final VoidCallback? aksiVerifikasiPengembalian;
  const CardListMonitoringPengembalianWidget({
    super.key,
    required this.kodePeminjaman,
    required this.namaPeminjam,
    required this.tanggalPinjam,
    required this.tanggalPengembalian,
    required this.listAlatDikembalikan,
    required this.terlambat,
    this.aksiVerifikasiPengembalian,
  });

  @override
  Widget build(BuildContext context) {

    final Color warnaBg = terlambat ? Color(0xFFE6D0D0) : Theme.of(context).colorScheme.secondary;
    final Color warnaFg = terlambat ? Color(0xFF822424) : Theme.of(context).colorScheme.onSecondary;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: warnaBg,
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
                  color: warnaFg,
                ),
              ),
              Text(
                tanggalPinjam,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: warnaFg,
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
              color: warnaFg,
            ),
          ),

          Text(
            listAlatDikembalikan,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: warnaFg,
            ),
          ),

          Row(
            children: [
              Icon(
                Icons.event_available,
                size: 14,
                color: warnaFg,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Waktu pengembalian: $tanggalPengembalian",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: warnaFg,
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
              color: warnaFg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: aksiVerifikasiPengembalian,
              style: ElevatedButton.styleFrom(
                backgroundColor: warnaFg,
              ),
              child: Text(
                terlambat ? "Konfirmasi Pengembalian Terlambat" : "Konfirmasi Pengembalian",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: warnaBg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
