import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:creaventory/widgets/card_request_peminjaman_widget.dart';

class MonitoringPeminjamanScreen extends StatefulWidget {
  const MonitoringPeminjamanScreen({super.key});

  @override
  State<MonitoringPeminjamanScreen> createState() =>
      _MonitoringPeminjamanScreenState();
}

class _MonitoringPeminjamanScreenState
    extends State<MonitoringPeminjamanScreen> {
  final List<Map<String, dynamic>> requests = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "barang": "1 Tablet iPad, 1 Stylus Pen",
    },
    {
      "kode": "TRX24578966",
      "nama": "Richa Ferdinyoy",
      "barang": "1 Kamera DSLR",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Monitoring\nPeminjaman"),
      drawer: NavigationDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          children: requests
              .map(
                (request) => CardRequestPeminjamanWidget(
                  kodePeminjaman: request["kode"],
                  namaPeminjam: request["nama"],
                  daftarBarang: request["barang"],
                  disetujui: () => Navigator.of(context).pushNamed('/cetak_kartu_peminjaman'),
                  ditolak: () {
                    debugPrint("Reject ${request["kode"]}");
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
