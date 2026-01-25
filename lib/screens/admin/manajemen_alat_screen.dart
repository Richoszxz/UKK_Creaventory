import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:creaventory/widgets/card_list_alat_widget.dart';
import 'package:creaventory/screens/admin/detail_alat_screen.dart';

class ManajemenAlatScreen extends StatefulWidget {
  const ManajemenAlatScreen({super.key});

  @override
  State<ManajemenAlatScreen> createState() => _ManajemenAlatScreenState();
}

class _ManajemenAlatScreenState extends State<ManajemenAlatScreen> {
  List<Map<String, dynamic>> alatList = [
    {
      "nama": "Tablet iPad",
      "kategori": "Elektronik",
      "stok": 1,
      "spesifikasi": "Layar 10.2 inci, Wi-Fi, 64GB",
      "deskripsi": "Tablet canggih untuk produktivitas dan hiburan.",
      "gambar": null,
    },
    {
      "nama": "Kamera DSLR",
      "kategori": "Fotografi",
      "stok": 1,
      "spesifikasi": "Sensor Full Frame, 24MP",
      "deskripsi": "Kamera profesional untuk fotografi berkualitas tinggi.",
      "gambar": null,
    },
    {
      "nama": "Proyektor Portabel",
      "kategori": "Presentasi",
      "stok": 1,
      "spesifikasi": "Resolusi 1080p, Konektivitas HDMI",
      "deskripsi": "Proyektor ringan untuk presentasi di mana saja.",
      "gambar": null,
    },
    {
      "nama": "Speaker Bluetooth",
      "kategori": "Audio",
      "stok": 1,
      "spesifikasi": "Daya 20W, Tahan Air",
      "deskripsi": "Speaker nirkabel untuk musik di luar ruangan.",
      "gambar": null,
    },
    {
      "nama": "Laptop Gaming",
      "kategori": "Komputer",
      "stok": 1,
      "spesifikasi": "Intel i7, RAM 16GB, GPU RTX 3060",
      "deskripsi": "Laptop bertenaga tinggi untuk gaming dan multitasking.",
      "gambar": null,
    },
  ];

  String selectedKategori = "Semua";

  List<String> get kategoriList {
    final kategori = alatList
        .map((e) => e["kategori"].toString())
        .toSet()
        .toList();

    kategori.insert(0, "Semua");
    return kategori;
  }

  List<Map<String, dynamic>> get filteredAlat {
    if (selectedKategori == "Semua") {
      return alatList;
    }

    return alatList
        .where((alat) => alat["kategori"] == selectedKategori)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Manajemen Alat"),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          BarPencarianWidget(hintText: "Cari alat..."),

          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Row(
              children: [
                Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedKategori,
                      dropdownColor: Theme.of(context).colorScheme.primary,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),

                      items: kategoriList.map((kategori) {
                        return DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedKategori = value!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  "Kategori terpilih: $selectedKategori",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                itemCount: alatList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 kolom
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.70, // tinggi card
                ),
                itemBuilder: (context, index) {
                  final alat = alatList[index];

                  return CardListAlatWidget(
                    namaAlat: alat["nama"]!,
                    spesifikasiAlat: alat["spesifikasi"]!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailAlatScreen(
                            heroTag: "alat_$index",
                            alat: alat,
                          ),
                        ),
                      );
                    },
                    tombolAksi: [
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/edit_alat'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          debugPrint("Hapus ${alat["nama"]}");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Hapus",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/tambah_alat'),
        child: Icon(Icons.add_outlined),
        shape: CircleBorder(),
      ),
    );
  }
}

// Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       debugPrint("Pinjam ${alat["nama"]}");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "+ Pinjam",
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: Theme.of(context).colorScheme.onPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
