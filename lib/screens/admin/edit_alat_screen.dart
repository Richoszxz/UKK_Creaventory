import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';
import 'package:flutter/foundation.dart';

class EditAlatScreen extends StatefulWidget {
  final ModelAlat data;
  const EditAlatScreen({super.key, required this.data});

  @override
  State<EditAlatScreen> createState() => _EditAlatScreenState();
}

class _EditAlatScreenState extends State<EditAlatScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaAlatController = TextEditingController();
  final TextEditingController stokAlatController = TextEditingController();
  final TextEditingController spesifikasiAlatController =
      TextEditingController();

  final KategoriService _kategoriService = KategoriService();

  int? kategoriAlatTerpilih;
  String? kondisiAlatTerpilih;
  File? gambar;
  Uint8List? gambarBytes;
  String? namaFile;

  List<ModelKategori> listKategori = [];

  final List<String> kondisiList = ["baik", "rusak", "pemeliharaan"];

  Future<void> _loadKategori() async {
    try {
      final data = await _kategoriService.ambilKategori();
      setState(() {
        listKategori = data;
      });
    } catch (e) {
      debugPrint("Gagal load kategori: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    final alat = widget.data;
    _loadKategori();

    namaAlatController.text = alat.namaAlat;
    stokAlatController.text = alat.stokAlat.toString();
    spesifikasiAlatController.text = alat.spesifikasiAlat ?? '';

    kategoriAlatTerpilih = alat.idKategori;
    kondisiAlatTerpilih = alat.kondisiAlat;

    if (alat.gambarUrl != null && alat.gambarUrl!.isNotEmpty) {
      // kalau gambar dari network, biarkan null
      // preview pakai Image.network (lihat step 4)
    }
  }

  // ================= PICK FILE =================
  Future<void> pilihGambar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        namaFile = result.files.single.name;

        if (kIsWeb) {
          gambarBytes = result.files.single.bytes;
          gambar = null;
        } else {
          gambar = File(result.files.single.path!);
          gambarBytes = null;
        }
      });
    }
  }

  void simpanPerubahan() async {
    if (_formKey.currentState!.validate()) {
      try {
        await AlatService().editAlat(
          idAlat: widget.data.idAlat,
          namaAlat: namaAlatController.text,
          stokAlat: int.parse(stokAlatController.text),
          idKategori: kategoriAlatTerpilih!,
          kondisi: kondisiAlatTerpilih!,
          spesifikasi: spesifikasiAlatController.text,
          gambar: gambar, // File? (opsional)
          gambarBytes: gambarBytes,
          namaFile: namaFile,
        );

        if (mounted) Navigator.pop(context);
        AlertHelper.showSuccess(context, "Berhasil update alat");
      } catch (e) {
        AlertHelper.showError(context, "Gagal update alat");
      }
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
              _dropdownKategori(),

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
              _dropdownKondisi(),

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

  Widget _dropdownKategori() {
    return DropdownButtonFormField<int>(
      value: kategoriAlatTerpilih,
      style: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.onSecondary,
        fontSize: 15,
      ),
      hint: Text(
        "Pilih kategori",
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primary,
        ),
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
      items: listKategori.map((kategori) {
        return DropdownMenuItem<int>(
          value: kategori.idKategori,
          child: Text(kategori.namaKategori),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => kategoriAlatTerpilih = value);
      },
      validator: (value) => value == null ? "Wajib memilih kategori" : null,
    );
  }

  Widget _dropdownKondisi() {
    return DropdownButtonFormField<String>(
      value: kondisiAlatTerpilih,
      style: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      hint: Text(
        "Pilih kondisi",
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 15,
        ),
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
      items: kondisiList.map((kondisi) {
        return DropdownMenuItem<String>(value: kondisi, child: Text(kondisi));
      }).toList(),
      onChanged: (value) {
        setState(() => kondisiAlatTerpilih = value);
      },
      validator: (value) => value == null ? "Wajib memilih kondisi" : null,
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
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: kIsWeb
                  ? (gambarBytes != null
                        // 🌐 WEB → preview dari memory
                        ? Image.memory(gambarBytes!, fit: BoxFit.cover)
                        // 🌐 WEB → belum pilih, tapi ada dari server
                        : (widget.data.gambarUrl != null &&
                                  widget.data.gambarUrl!.isNotEmpty
                              ? Image.network(
                                  widget.data.gambarUrl!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_outlined)))
                  : (gambar != null
                        // 📱 MOBILE → preview dari file
                        ? Image.file(gambar!, fit: BoxFit.cover)
                        // 📱 MOBILE → dari server
                        : (widget.data.gambarUrl != null &&
                                  widget.data.gambarUrl!.isNotEmpty
                              ? Image.network(
                                  widget.data.gambarUrl!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_outlined))),
            ),

            const SizedBox(width: 12),

            /// Nama file
            Expanded(
              child: Text(
                namaFile ?? "Upload foto alat",
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
