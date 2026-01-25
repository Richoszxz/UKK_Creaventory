import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFD0E6D1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 260,
            child: DrawerHeader(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Color(0xFF248250)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFD0E6D1),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 90,
                        color: Color(0xFF248250),
                      ),
                    ),
                    Text(
                      "Admin Creaventory",
                      style: GoogleFonts.poppins(
                        color: Color(0xFFD0E6D1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/profil'),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Lihat Profile",
                        style: GoogleFonts.poppins(
                          color: Color(0xFFD0E6D1),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard_outlined, color: Color(0xFF424242)),
            title: Text(
              'Dashboard',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/dashboard'),
          ),
          ListTile(
            leading: Icon(Icons.group_outlined, color: Color(0xFF424242)),
            title: Text(
              'Manajemen Pengguna',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/manajemen_pengguna'),
          ),
          ListTile(
            leading: Icon(Icons.build_outlined, color: Color(0xFF424242)),
            title: Text(
              'Manajemen Alat',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/manajemen_alat'),
          ),
          ListTile(
            leading: Icon(Icons.category_outlined, color: Color(0xFF424242)),
            title: Text(
              'Manajemen Kategori',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/manajemen_kategori'),
          ),
          ListTile(
            leading: Icon(Icons.assignment_outlined, color: Color(0xFF424242)),
            title: Text(
              'Manajemen Peminjaman',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/manajemen_data_peminjaman'),
          ),
          ListTile(
            leading: Icon(Icons.assignment_returned_outlined, color: Color(0xFF424242)),
            title: Text(
              'Manajemen Pengembalian',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/manajemen_data_pengembalian'),
          ),
          ListTile(
            leading: Icon(Icons.assignment_add, color: Color(0xFF424242)),
            title: Text(
              'Pengajuan Peminjaman',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/pengajuan_peminjaman'),
          ),
          ListTile(
            leading: Icon(Icons.receipt_long_outlined, color: Color(0xFF424242)),
            title: Text(
              'Riwayat Peminjaman',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/riwayat_peminjaman'),
          ),
          ListTile(
            leading: Icon(Icons.track_changes_outlined, color: Color(0xFF424242)),
            title: Text(
              'Monitoring Peminjaman',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/monitoring_peminjaman'),
          ),
          ListTile(
            leading: Icon(Icons.fact_check_outlined, color: Color(0xFF424242)),
            title: Text(
              'Monitoring Pengembalian',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/monitoring_pengembalian'),
          ),

          ListTile(
            leading: Icon(Icons.history_outlined, color: Color(0xFF424242)),
            title: Text(
              'Log Aktivitas',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF424242),
              ),
            ),
            onTap: () => Navigator.pushNamed(context, '/log_aktivitas'),
          ),
        ],
      ),
    );
  }
}
