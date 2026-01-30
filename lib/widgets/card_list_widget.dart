import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardListWidget extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? diEdit;
  final VoidCallback? diHapus;
  final VoidCallback? diDetail;
  const CardListWidget({
    super.key,
    this.title,
    this.subtitle,
    this.diEdit,
    this.diHapus,
    this.diDetail,
  });

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 15, right: 10),
          title: Text(
            widget.title ?? '',
            maxLines: 1,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            widget.subtitle ?? '',
            maxLines: 1,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 16,
            ),
          ),
          trailing: PopupMenuButton<String>(
            color: Theme.of(
              context,
            ).colorScheme.secondary, // Warna background menu
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary, // warna lingkaran
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_horiz_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'detail',
                onTap: widget.diDetail,
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Text(
                      'Detail',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'edit',
                onTap: widget.diEdit,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'hapus',
                onTap: widget.diHapus,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Text(
                      'Hapus',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
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
}
