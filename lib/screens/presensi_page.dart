
import 'package:flutter/material.dart';
import '../models/siswa.dart';
import '../services/siswa_service.dart';
import 'rekap_page.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  List<Siswa> daftarSiswa = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSiswa();
  }

  // Mengambil data siswa dari JSON
  Future<void> loadSiswa() async {
    try {
      final data = await SiswaService().ambilDataSiswa();

      setState(() {
        daftarSiswa = data;
        loading = false;
      });
    }} catch (e) {
        setState(() {
          loading = false;
          errorMessage = 'Gagal membaca data siswa: $e';
    });
}
  }

  // Menghitung siswa yang hadir
  int get jumlahHadir {
    return daftarSiswa.where((s) => s.hadir).length;
  }

  // Menghitung siswa yang tidak hadir
  int get jumlahTidakHadir {
    return daftarSiswa.length - jumlahHadir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi XI RPL'),
        centerTitle: true,
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : : errorMessage != null
    ? Center(
        child: Text(errorMessage!),
      )
    : daftarSiswa.isEmpty
        ? const Center(
            child: Text('Data siswa kosong'),
          )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Daftar Kehadiran Siswa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Daftar siswa
                    Expanded(
                      child: ListView.builder(
                        itemCount: daftarSiswa.length,
                        itemBuilder: (context, index) {
                          final siswa = daftarSiswa[index];

                          return CheckboxListTile(
                            title: Text(siswa.nama),
                            subtitle: Text(
                              'No. Absen: ${siswa.noAbsen}',
                            ),
                            value: siswa.hadir,

                            onChanged: (value) {
                              setState(() {
                                siswa.hadir = value ?? false;
                              });
                            },
                          );
                        },
                      ),
                    ),

                    // Tombol simpan
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RekapPage(
                                    daftarSiswa: daftarSiswa,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text('Simpan'),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
