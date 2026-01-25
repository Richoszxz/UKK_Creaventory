import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:creaventory/widgets/card_list_monitoring_pengembalian_widget.dart';
import 'package:creaventory/screens/petugas/konfirmasi_pengembalian_screen.dart';

class MonitoringPengembalianScreen extends StatefulWidget {
  const MonitoringPengembalianScreen({super.key});

  @override
  State<MonitoringPengembalianScreen> createState() =>
      _MonitoringPengembalianScreenState();
}

class _MonitoringPengembalianScreenState
    extends State<MonitoringPengembalianScreen> {
  final List<Map<String, dynamic>> listDataMonitoringPengembalian = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "email": "richoferdinand@gmail.com",
      "barang": [
        {"nama": "iPad M3 Pro", "qty": 1},
        {"nama": "Stylus Pen", "qty": 1},
      ],
      "tglPinjam": "18/01/2026",
      "tglRencanaPengembalian": "19/01/2026",
      "tglPengembalian": "19/01/2026",
      "terlambat": false,
    },
    {
      "kode": "TRX45672905",
      "nama": "Richa Ferdinyoy",
      "email": "richonyoy@gmail.com",
      "barang": [
        {"nama": "iPad M3 Pro", "qty": 1},
        {"nama": "Stylus Pen", "qty": 1},
      ],
      "tglPinjam": "17/01/2026",
      "tglRencanaPengembalian": "19/01/2026",
      "tglPengembalian": "20/01/2026",
      "terlambat": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Monitoring\nPengembalian"),
      drawer: NavigationDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          children: listDataMonitoringPengembalian
              .map(
                (data) => CardListMonitoringPengembalianWidget(
                  kodePeminjaman: data["kode"]!,
                  namaPeminjam: data["nama"]!,
                  listAlatDikembalikan: data['barang']
                      .map((data) => "${data["qty"]} ${data["nama"]}")
                      .join(", "),
                  tanggalPinjam: data["tglPinjam"]!,
                  tanggalPengembalian: data["tglPengembalian"]!,
                  terlambat: data["terlambat"]!,
                  aksiVerifikasiPengembalian: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            KonfirmasiPengembalianScreen(dataPengembalian: data),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
