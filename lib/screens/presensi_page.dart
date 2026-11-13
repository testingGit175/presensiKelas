
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
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadSiswa();
  }

  // Mengambil data siswa dari file JSON
  Future<void> loadSiswa() async {
    try {
      final data = await SiswaService().ambilDataSiswa();

      if (!mounted) return;

      setState(() {
        daftarSiswa = data;
        loading = false;
        errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        errorMessage = 'Gagal mengambil data siswa: $e';
      });
    }
  }

  // Menghitung jumlah seluruh siswa
  int get jumlahSiswa {
    return daftarSiswa.length;
  }

  // Menghitung jumlah siswa yang hadir
  int get jumlahHadir {
    return daftarSiswa.where((siswa) => siswa.hadir).length;
  }

  // Menghitung jumlah siswa yang tidak hadir
  int get jumlahTidakHadir {
    return jumlahSiswa - jumlahHadir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Presensi XI RPL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )

          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 50,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            loadSiswa();
                          },
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                )

              : daftarSiswa.isEmpty
                  ? const Center(
                      child: Text('Data siswa belum tersedia'),
                    )

                  : Column(
                      children: [
                        // Judul halaman
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

                        // Ringkasan presensi
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.green.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        const Text('Hadir'),
                                        const SizedBox(height: 5),
                                        Text(
                                          '$jumlahHadir',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Card(
                                  color: Colors.red.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        const Text('Tidak Hadir'),
                                        const SizedBox(height: 5),
                                        Text(
                                          '$jumlahTidakHadir',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Daftar siswa
                        Expanded(
                          child: ListView.builder(
                            itemCount: daftarSiswa.length,
                            itemBuilder: (context, index) {
                              final siswa = daftarSiswa[index];

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5,
                                ),
                                child: CheckboxListTile(
                                  secondary: CircleAvatar(
                                    backgroundColor:
                                        siswa.hadir
                                            ? Colors.green
                                            : Colors.grey,
                                    child: Text(
                                      '${siswa.noAbsen}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  title: Text(
                                    siswa.nama,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  subtitle: Text(
                                    siswa.hadir
                                        ? 'Status: Hadir'
                                        : 'Status: Tidak Hadir',
                                  ),

                                  value: siswa.hadir,

                                  activeColor: Colors.green,

                                  onChanged: (value) {
                                    setState(() {
                                      siswa.hadir = value ?? false;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        // Tombol simpan
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.save),
                              label: const Text(
                                'Simpan Presensi',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),

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
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}
