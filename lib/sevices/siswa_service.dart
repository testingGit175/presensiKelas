
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/siswa.dart';

class SiswaService {
  Future<List<Siswa>> ambilDataSiswa() async {
    // Membaca file JSON
    String data = await rootBundle.loadString(
      'assets/siswa.json',
    );

    // Mengubah JSON menjadi List
    List hasil = jsonDecode(data);

    // Mengubah setiap data menjadi objek Siswa
    return hasil.map((item) {
      return Siswa.fromJson(item);
    }).toList();
  }
}
