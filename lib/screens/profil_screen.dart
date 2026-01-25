import 'package:flutter/material.dart';
import 'package:creaventory/export.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  // Simulasi pengambilan data dari tabel public.pengguna
  final Map<String, dynamic> userData = {
    "id_user": "550e8400-e29b-41d4-a716-446655440000", // UUID
    "username": "Richo Ferdinand",
    "email": "richo@example.com",
    "role": "peminjam", // role_enum (peminjam/admin)
    "status": true,
    "created_at": "2024-01-20T10:00:00Z",
  };

  @override
  Widget build(BuildContext context) {
    // Logika Inisial dari Username
    String username = userData['username'] ?? "User";
    String inisial = username.substring(0, 1).toUpperCase();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(judulAppBar: "Profil"),
      drawer: const NavigationDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER SECTION ---
            _buildHeader(username, userData['role'], inisial),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Data Pengguna"),

                  // Menampilkan data sesuai kolom di tabel
                  _buildInfoCard(
                    "Email",
                    userData['email'],
                    Icons.email_outlined,
                  ),
                  _buildInfoCard(
                    "User ID (UUID)",
                    userData['id_user'],
                    Icons.fingerprint,
                    isSmallText: true,
                  ),
                  _buildInfoCard(
                    "Status Akun",
                    userData['status'] ? "Aktif" : "Non-aktif",
                    Icons.verified_user_outlined,
                  ),
                  _buildInfoCard(
                    "Bergabung Sejak",
                    userData['created_at'].toString().split('T')[0],
                    Icons.calendar_today_outlined,
                  ),

                  const SizedBox(height: 10),
                  _buildLabel("Keamanan"),

                  _buildMenuTile("Ubah Password", Icons.lock_outline, () {}),
                  _buildMenuTile(
                    "Hapus Akun",
                    Icons.delete_outline,
                    () {},
                    isDestructive: true,
                  ),

                  const SizedBox(height: 10),
                  _buildLogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildHeader(String name, String role, String initial) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              initial,
              style: GoogleFonts.poppins(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
            ),
          ),
          // Badge Role sesuai Enum
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              role.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String value,
    IconData icon, {
    bool isSmallText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
        border: BoxBorder.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: isSmallText ? 12 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black87),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isDestructive ? Colors.red : Color(0xFF424242),
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF424242),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_outlined, color: Colors.white, size: 25,),
            Text(
              "Keluar Akun",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
