import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? judulAppBar;
  final bool? tombolKembali;
  const AppBarWidget({super.key, this.judulAppBar, this.tombolKembali = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(judulAppBar ?? "Creaventory", textAlign: TextAlign.center,),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      toolbarHeight: 90,
      titleSpacing: 0,
      leadingWidth: 80,
      elevation: 10,
      shadowColor: Colors.black,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 30, top: 20), // jarak kiri
          child: IconButton(
            icon: Icon(
              tombolKembali == true ? Icons.arrow_back_ios : Icons.menu,
              size: 35, // ukuran ikon drawer
            ),
            onPressed: () {
              if (tombolKembali == true) {
                Navigator.pop(context);
              } else {
                Scaffold.of(context).openDrawer();
              }
            }, // buka drawer custom
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(110);
}
