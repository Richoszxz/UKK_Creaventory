import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class EditPenggunaScreen extends StatefulWidget {
  final ModelPengguna data;
  const EditPenggunaScreen({super.key, required this.data});

  @override
  State<EditPenggunaScreen> createState() => _EditPenggunaScreenState();
}

class _EditPenggunaScreenState extends State<EditPenggunaScreen> {
  final PenggunaService _penggunaService = PenggunaService();
  final _formKey = GlobalKey<FormState>();
  // Controller untuk input
  late TextEditingController _userNameController;

  String? _roleTerpilih;

  final List<String> daftarRole = ['peminjam', 'petugas'];

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.data.userName);
    _roleTerpilih = widget.data.role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        judulAppBar: 'Edit\nPengguna',
        tombolKembali: true,
      ),
      drawer: const NavigationDrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Nama Pengguna:'),
                _textField(
                  controller: _userNameController,
                  hint: 'Masukkan nama baru',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Nama tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 20),

                _label('Role:'),
                DropdownButtonFormField<String>(
                  value: _roleTerpilih,
                  dropdownColor: Theme.of(context).colorScheme.secondary,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
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
                  items: daftarRole
                      .map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: Text(
                            role.toUpperCase(),
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _roleTerpilih = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Role harus dipilih' : null,
                ),
                const SizedBox(height: 30),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _simpanPerubahan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Simpan Perubahan',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk update ke database
  void _simpanPerubahan() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _penggunaService.editPengguna(widget.data.idUser!, {
          'username': _userNameController.text,
          'role': _roleTerpilih,
        });

        if (mounted) Navigator.pop(context);
        AlertHelper.showSuccess(context, 'Berhasil menyimpan perubahan !');
      } catch (e) {
        AlertHelper.showError(context, 'Gagal menyimpan perubahan !');
        debugPrint('Error $e');
      }
    }
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
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
      style: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
    );
  }
}
