import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:creaventory/widgets/card_list_alat_widget.dart';

class PengajuanPeminjamanScreen extends StatefulWidget {
  const PengajuanPeminjamanScreen({super.key});

  @override
  State<PengajuanPeminjamanScreen> createState() =>
      _PengajuanPeminjamanScreenState();
}

class _PengajuanPeminjamanScreenState extends State<PengajuanPeminjamanScreen> {
  List<Map<String, dynamic>> alatList = [
    {
      "nama": "Tablet iPad",
      "kategori": "Elektronik",
      "spesifikasi": "Layar 10.2 inci, Wi-Fi, 64GB",
      "deskripsi": "Tablet canggih untuk produktivitas dan hiburan.",
    },
    {
      "nama": "Kamera DSLR",
      "kategori": "Fotografi",
      "spesifikasi": "Sensor Full Frame, 24MP",
      "deskripsi": "Kamera profesional untuk fotografi berkualitas tinggi.",
    },
    {
      "nama": "Proyektor Portabel",
      "kategori": "Presentasi",
      "spesifikasi": "Resolusi 1080p, Konektivitas HDMI",
      "deskripsi": "Proyektor ringan untuk presentasi di mana saja.",
    },
    {
      "nama": "Speaker Bluetooth",
      "kategori": "Audio",
      "spesifikasi": "Daya 20W, Tahan Air",
      "deskripsi": "Speaker nirkabel untuk musik di luar ruangan.",
    },
    {
      "nama": "Laptop Gaming",
      "kategori": "Komputer",
      "spesifikasi": "Intel i7, RAM 16GB, GPU RTX 3060",
      "deskripsi": "Laptop bertenaga tinggi untuk gaming dan multitasking.",
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

  int jumlahRequest = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Pengajuan\nPeminjaman"),
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

          // ================= GRID ALAT =================
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
                    tombolAksi: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("Pinjam ${alat["nama"]}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "+ Pinjam",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
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
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed('/keranjang_peminjaman'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.shopping_bag_outlined, size: 30,),
            shape: CircleBorder(),
          ),

          // Badge notifikasi
          if (jumlahRequest > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    jumlahRequest.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
