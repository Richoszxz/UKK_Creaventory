import 'package:creaventory/export.dart';
import 'package:flutter/material.dart';

class DetailPenggunaScreen extends StatefulWidget {
  final ModelPengguna data;
  const DetailPenggunaScreen({super.key, required this.data});

  @override
  State<DetailPenggunaScreen> createState() => _DetailPenggunaScreenState();
}

class _DetailPenggunaScreenState extends State<DetailPenggunaScreen> {
  @override
  Widget build(BuildContext context) {
    String nama = widget.data.userName!;
    String inisial = nama
        .split(' ')
        .map((e) => e[0])
        .take(2)
        .join()
        .toUpperCase();

    return Scaffold(
      appBar: AppBarWidget(
        judulAppBar: "Detail\nPengguna",
        tombolKembali: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        inisial,
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nama,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    _buildBadgeStatus(widget.data.role!.toUpperCase()),
                    _buildStaticField("Email", widget.data.email!),
                    _buildStaticField(
                      "Status akun",
                      widget.data.status! ? "Aktif" : "Nonaktif",
                    ),
                    _buildStaticField(
                      "Bergabung sejak",
                      widget.data.createdAt!.toString().split('T')[0],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E9D9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF2D7D46),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF424242),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFD9E9D9),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF2D7D46).withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF2D7D46),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
