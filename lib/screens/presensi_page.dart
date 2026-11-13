import 'package:flutter/material.dart';
import '../models/siswa.dart';
import '../sevices/siswa_service.dart';
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
      if (!mounted) return;

      setState(() {
        daftarSiswa = data;
        loading = false;
      });
<<<<<<< HEAD
    }} catch (e) {
        setState(() {
          loading = false;
          errorMessage = 'Gagal membaca data siswa: $e';
    });
}
=======
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
>>>>>>> a39f153a267fd9260e2ac8e77bbdc69828e82f6b
  }

  // Menghitung siswa yang hadir
  int get jumlahHadir => daftarSiswa.where((s) => s.hadir).length;

  // Menghitung siswa yang tidak hadir
  int get jumlahTidakHadir => daftarSiswa.length - jumlahHadir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi XI RPL'),
        centerTitle: true,
      ),
      body: loading
<<<<<<< HEAD
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
=======
          ? const Center(child: CircularProgressIndicator())
          : daftarSiswa.isEmpty
              ? const Center(
                  child: Text('Data siswa kosong atau gagal dibaca'),
                )
>>>>>>> a39f153a267fd9260e2ac8e77bbdc69828e82f6b
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: daftarSiswa.length,
                        itemBuilder: (context, index) {
                          final siswa = daftarSiswa[index];
                          return CheckboxListTile(
                            title: Text(siswa.nama),
                            subtitle: Text('No. Absen: ${siswa.noAbsen}'),
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RekapPage(
                                  daftarSiswa: daftarSiswa,
                                ),
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
