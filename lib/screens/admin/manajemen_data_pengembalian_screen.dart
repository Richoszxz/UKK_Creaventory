import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import '../../widgets/card_data_pengembalian_widget.dart';
import 'package:creaventory/screens/admin/tambah_data_pengembalian_screen.dart';
import 'package:creaventory/screens/admin/detail_data_pengembalian_screen.dart';
import 'package:creaventory/screens/admin/edit_data_pengembalian_screen.dart';

class ManajemenDataPengembalianScreen extends StatefulWidget {
  const ManajemenDataPengembalianScreen({super.key});

  @override
  State<ManajemenDataPengembalianScreen> createState() =>
      _ManajemenDataPengembalianScreenState();
}

class _ManajemenDataPengembalianScreenState
    extends State<ManajemenDataPengembalianScreen> {
  final List<Map<String, dynamic>> dummyPengembalian = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "tglPinjam": "18/01/2026",
      "tglRencanaKembali": "19/01/2026",
      "tglKembali": "19/01/2026",
      "status": "Tepat Waktu",
      "petugas": "Petugas Admin 1",
      "alat": [
        {"nama": "iPad M3 Pro", "qty": "1", "kondisi": "Baik"},
        {"nama": "Stylus Pen", "qty": "1", "kondisi": "Baik"},
      ],
    },
    {
      "kode": "TRX45672905",
      "nama": "Richa Ferdinyoy",
      "tglPinjam": "17/01/2026",
      "tglRencanaKembali": "20/01/2026",
      "tglKembali": "22/01/2026",
      "status": "Terlambat",
      "petugas": "Petugas Admin 2",
      "alat": [
        {"nama": "Sony A7 IV", "qty": "1", "kondisi": "Baik"},
        {"nama": "Lens 35mm", "qty": "1", "kondisi": "Rusak"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Manajemen\nPengembalian"),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          BarPencarianWidget(hintText: "Cari data pengembalian..."),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: dummyPengembalian.length,
                itemBuilder: (context, index) {
                  final data = dummyPengembalian[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CardDataPengembalianWidget(
                      kode: data["kode"]!,
                      nama: data["nama"]!,
                      tglPinjam: data["tglPinjam"]!,
                      tglKembali: data["tglKembali"]!,
                      onDetail: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPengembalianScreen(data: data),
                          ),
                        );
                      },
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditDataPengembalianScreen(data: data),
                          ),
                        );
                      },
                      onDelete: () {
                        debugPrint("Delete");
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahDataPengembalianScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }
}
