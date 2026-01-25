import 'package:creaventory/widgets/card_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class ManajemenKategoriScreen extends StatefulWidget {
  const ManajemenKategoriScreen({super.key});

  @override
  State<ManajemenKategoriScreen> createState() =>
      _ManajemenKategoriScreenState();
}

class _ManajemenKategoriScreenState extends State<ManajemenKategoriScreen> {
  List<Map<String, String>> daftarKategori = [
    {"nama": "Elektronik", "deskripsi": "Perangkat elektronik dan gadget."},
    {"nama": "Fotografi", "deskripsi": "Alat dan perangkat fotografi."},
    {"nama": "Presentasi", "deskripsi": "Perangkat presentasi."},
    {"nama": "Audio", "deskripsi": "Perangkat audio dan alat musik."},
    {"nama": "Komputer", "deskripsi": "Komponen dan perangkat komputer."},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Manajemen\nKategori"),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          BarPencarianWidget(hintText: "Cari kategori..."),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: daftarKategori
                    .map(
                      (kategori) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                        ),
                        child: CardListWidget(
                          title: kategori['nama'],
                          subtitle: kategori['deskripsi'],
                          diEdit: () => Navigator.of(context).pushNamed('/edit_kategori'),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/tambah_kategori'),
        child: Icon(Icons.add_outlined),
        shape: CircleBorder(),
      ),
    );
  }
}
