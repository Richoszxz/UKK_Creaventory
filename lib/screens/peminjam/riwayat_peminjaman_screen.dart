import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:creaventory/widgets/card_list_riwayat_peminjaman_widget.dart';
import 'package:creaventory/screens/peminjam/pengajuan_pengembalian_screen.dart';

class RiwayatPeminjamanScreen extends StatefulWidget {
  const RiwayatPeminjamanScreen({super.key});

  @override
  State<RiwayatPeminjamanScreen> createState() =>
      _RiwayatPeminjamanScreenState();
}

class _RiwayatPeminjamanScreenState extends State<RiwayatPeminjamanScreen> {
  final List<Map<String, dynamic>> dummyRiwayatPeminjaman = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "tanggalPinjam": "19 Jan 2026",
      "tanggalKembali": "21 Jan 2026",
      "alat": [
        {"nama": "iPad M3 Pro", "qty": 1},
        {"nama": "Stylus Pen", "qty": 1},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Riwayat\nPeminjaman"),
      drawer: NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: dummyRiwayatPeminjaman
              .map(
                (peminjaman) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CardListRiwayatPeminjamanWidget(
                    kodePeminjaman: peminjaman["kode"],
                    namaPeminjam: peminjaman["nama"],
                    tanggalPinjam: peminjaman["tanggalPinjam"],
                    tanggalRencanaKembali: peminjaman["tanggalKembali"],
                    listAlatDipinjam: peminjaman["alat"]
                        .map((alat) => "${alat["qty"]} ${alat["nama"]}")
                        .join(", "),
                    aksiPengajuanPengembalian: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PengajuanPengembalianScreen(peminjaman: peminjaman),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
