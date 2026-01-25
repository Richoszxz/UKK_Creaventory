import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class EditAlatScreen extends StatefulWidget {
  const EditAlatScreen({super.key});

  @override
  State<EditAlatScreen> createState() => _EditAlatScreenState();
}

class _EditAlatScreenState extends State<EditAlatScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaAlatController = TextEditingController();
  final TextEditingController stokAlatController = TextEditingController();
  final TextEditingController spesifikasiAlatController =
      TextEditingController();

  String? kategoriAlatTerpilih;
  String? kondisiAlatTerpilih;
  File? gambar;

  final List<String> kategoriList = [
    "Elektronik",
    "Alat Tulis",
    "Multimedia",
    "Lainnya",
  ];

  final List<String> kondisiList = ["Baik", "Rusak Ringan", "Rusak Berat"];

  // ================= DUMMY DATA =================
  final Map<String, dynamic> dummyData = {
    "nama": "Laptop Asus VivoBook",
    "stok": "5",
    "kategori": "Elektronik",
    "kondisi": "Baik",
    "spesifikasi": "Core i5, RAM 8GB, SSD 512GB",
    "gambar": null, // isi file path kalau mau
  };

  @override
  void initState() {
    super.initState();

    /// isi form dari dummy
    namaAlatController.text = dummyData["nama"];
    stokAlatController.text = dummyData["stok"];
    kategoriAlatTerpilih = dummyData["kategori"];
    kondisiAlatTerpilih = dummyData["kondisi"];
    spesifikasiAlatController.text = dummyData["spesifikasi"];

    if (dummyData["gambar"] != null) {
      gambar = File(dummyData["gambar"]);
    }
  }

  // ================= PICK FILE =================
  Future<void> pilihGambar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        gambar = File(result.files.single.path!);
      });
    }
  }

  void simpanPerubahan() {
    if (_formKey.currentState!.validate()) {
      debugPrint("=== DATA UPDATE ===");
      debugPrint("Nama: ${namaAlatController.text}");
      debugPrint("Stok: ${stokAlatController.text}");
      debugPrint("Kategori: $kategoriAlatTerpilih");
      debugPrint("Kondisi: $kondisiAlatTerpilih");
      debugPrint("Spesifikasi: ${spesifikasiAlatController.text}");
      debugPrint("Gambar: ${gambar?.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(judulAppBar: "Edit Alat", tombolKembali: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= NAMA ALAT =================
              _label("Nama alat"),
              _textField(
                controller: namaAlatController,
                hint: "Nama alat...",
                validator: (value) =>
                    value!.isEmpty ? "Nama alat wajib diisi" : null,
              ),

              const SizedBox(height: 14),

              /// ================= KATEGORI =================
              _label("Kategori alat"),
              _dropdown(
                value: kategoriAlatTerpilih,
                hint: "Pilih kategori",
                items: kategoriList,
                onChanged: (value) {
                  setState(() => kategoriAlatTerpilih = value);
                },
              ),

              const SizedBox(height: 14),

              /// ================= STOK =================
              _label("Stok alat"),
              _textField(
                controller: stokAlatController,
                hint: "Jumlah stok...",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Stok wajib diisi" : null,
              ),

              const SizedBox(height: 14),

              /// ================= KONDISI =================
              _label("Kondisi alat"),
              _dropdown(
                value: kondisiAlatTerpilih,
                hint: "Pilih kondisi",
                items: kondisiList,
                onChanged: (value) {
                  setState(() => kondisiAlatTerpilih = value);
                },
              ),

              const SizedBox(height: 14),

              /// ================= SPESIFIKASI =================
              _label("Spesifikasi alat"),
              _textField(
                controller: spesifikasiAlatController,
                hint: "Masukkan spesifikasi...",
              ),

              const SizedBox(height: 14),

              /// ================= FOTO =================
              _label("Foto alat"),
              _uploadFotoField(),

              const SizedBox(height: 25),

              /// ================= BUTTON SIMPAN =================
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: simpanPerubahan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Simpan",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: const Color(0xFF424242),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primary,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(
        hint,
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      dropdownColor: Theme.of(context).colorScheme.secondary,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Wajib memilih $hint" : null,
    );
  }

  Widget _uploadFotoField() {
    return InkWell(
      onTap: pilihGambar,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: BoxBorder.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          children: [
            /// Preview Thumbnail
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: gambar == null
                  ? const Icon(Icons.image_outlined)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(gambar!, fit: BoxFit.cover),
                    ),
            ),

            const SizedBox(width: 12),

            /// Nama file
            Expanded(
              child: Text(
                gambar == null
                    ? "Upload foto alat"
                    : gambar!.path.split('/').last,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            const Icon(Icons.upload_file),
          ],
        ),
      ),
    );
  }
}
