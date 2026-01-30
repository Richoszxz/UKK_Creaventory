import 'dart:io';
import 'dart:typed_data';

import 'package:creaventory/export.dart';
import 'package:flutter/foundation.dart';

class AlatService {
  final _supabaseService = SupabaseService.client;

  Future<List<ModelAlat>> ambilAlat() async {
    try {
      final response = await _supabaseService
          .from('alat')
          .select('*, kategori(nama_kategori)')
          .order('nama_alat', ascending: true);

      return (response as List<dynamic>)
          .map((item) => ModelAlat.fromMap(item))
          .toList();
    } on Exception catch (e) {
      throw Exception('Gagal mengambil alat $e');
    }
  }

  // CREATE
  Future<void> tambahAlat(Map<String, dynamic> data) async {
    await _supabaseService.from('alat').insert(data);
  }

  // UPDATE
  Future<void> editAlat({
  required int idAlat,
  required String namaAlat,
  required int stokAlat,
  required int idKategori,
  required String kondisi,
  String? spesifikasi,
  File? gambar, // mobile
  Uint8List? gambarBytes,  // web
  String? namaFile,
}) async {
  String? imageUrl;

  if (gambar != null || gambarBytes != null) {
    imageUrl = await uploadGambar(
      file: gambar,
      bytes: gambarBytes,
      fileName: namaFile ?? "gambar.jpg",
    );
  }

  final data = {
    'nama_alat': namaAlat,
    'stok_alat': stokAlat,
    'id_kategori': idKategori,
    'kondisi_alat': kondisi,
    'spesifikasi_alat': spesifikasi,
    if (imageUrl != null) 'gambar_url': imageUrl,
    'updated_at': DateTime.now().toIso8601String(),
  };

  await _supabaseService
      .from('alat')
      .update(data)
      .eq('id_alat', idAlat);
}


  // DELETE
  Future<void> hapusAlat(int id) async {
    await _supabaseService.from('alat').delete().eq('id_alat', id);
  }

  // Di AlatService
  Future<String?> uploadGambar({
    File? file,
    Uint8List? bytes,
    required String fileName,
  }) async {
    try {
      // Buat nama file unik dengan timestamp
      final String uniqueName =
          '${DateTime.now().millisecondsSinceEpoch}_$fileName';
      final String path = uniqueName;

      if (kIsWeb && bytes != null) {
        // PROSES WEB
        await _supabaseService.storage
            .from('gambar_alat')
            .uploadBinary(
              path,
              bytes,
              fileOptions: const FileOptions(contentType: 'image/jpeg'),
            );
      } else if (file != null) {
        // PROSES MOBILE
        await _supabaseService.storage.from('gambar_alat').upload(path, file);
      } else {
        return null;
      }

      return _supabaseService.storage.from('gambar_alat').getPublicUrl(path);
    } catch (e) {
      debugPrint("Gagal upload ke storage: $e");
      return null;
    }
  }
}
