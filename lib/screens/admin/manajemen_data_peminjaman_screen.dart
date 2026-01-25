import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import '../../widgets/card_data_peminjaman_widget.dart';
import 'package:creaventory/screens/admin/tambah_data_peminjaman_screen.dart';
import 'package:creaventory/screens/admin/detail_data_peminjaman_screen.dart';
import 'package:creaventory/screens/admin/edit_data_peminjaman_screen.dart';

class ManajemenDataPeminjamanScreen extends StatefulWidget {
  const ManajemenDataPeminjamanScreen({super.key});

  @override
  State<ManajemenDataPeminjamanScreen> createState() =>
      _ManajemenDataPeminjamanScreenState();
}

class _ManajemenDataPeminjamanScreenState
    extends State<ManajemenDataPeminjamanScreen> {
  // Di ManajemenDataPeminjamanScreen
  final List<Map<String, dynamic>> dummyPeminjaman = [
    {
      "kode": "TRX24578965",
      "nama": "Richo Ferdinand",
      "email": "richoferdinand@gmail.com",
      "tglPinjam": "18 Jan 2026",
      "tglRencanaKembali": "19 Jan 2026",
      "status": "Dikembalikan",
      "petugas": "Petugas 1",
      "alat": [
        {"nama": "iPad M3 Pro", "qty": "1", "kondisi": "Baik"},
        {"nama": "Stylus Pen", "qty": "1", "kondisi": "Baik"},
      ],
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Mengirimkan variabel 'data' (item dari ListView) ke screen Detail
                            builder: (context) =>
                                DetailPeminjamanScreen(data: data),
                          ),
                        );
                      },
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditDataPeminjamanScreen(data: data),
                          ),
                        );
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
