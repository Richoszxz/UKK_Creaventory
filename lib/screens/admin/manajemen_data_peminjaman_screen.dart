import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import '../../widgets/card_data_peminjaman_widget.dart';
import 'package:creaventory/screens/admin/tambah_data_peminjaman_screen.dart';

class ManajemenDataPeminjamanScreen extends StatefulWidget {
  const ManajemenDataPeminjamanScreen({super.key});

  @override
  State<ManajemenDataPeminjamanScreen> createState() =>
      _ManajemenDataPeminjamanScreenState();
}

class _ManajemenDataPeminjamanScreenState
    extends State<ManajemenDataPeminjamanScreen> {
  final List<Map<String, String>> dummyPeminjaman = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "tglPinjam": "18/01/2026",
      "tglRencanaKembali": "19/01/2026",
    },
    {
      "kode": "TRX24578966",
      "nama": "Richa Ferdinyoy",
      "tglPinjam": "17/01/2026",
      "tglRencanaKembali": "20/01/2026",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Manajemen\nPeminjaman"),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          BarPencarianWidget(hintText: "Cari data peminjaman..."),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: dummyPeminjaman.length,
                itemBuilder: (context, index) {
                  final data = dummyPeminjaman[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CardDataPeminjamanWidget(
                      kode: data["kode"]!,
                      nama: data["nama"]!,
                      tglPinjam: data["tglPinjam"]!,
                      tglRencanaKembali: data["tglRencanaKembali"]!,
                      onDetail: () {
                        debugPrint("Detail ${data["kode"]}");
                      },
                      onEdit: () {
                        debugPrint("Edit ${data["kode"]}");
                      },
                      onDelete: () {
                        debugPrint("Delete ${data["kode"]}");
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
              builder: (context) => TambahDataPeminjamanScreen(),
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
