
import 'package:flutter/material.dart';
import '../models/siswa.dart';

class RekapPage extends StatelessWidget {
  final List<Siswa> daftarSiswa;

  const RekapPage({
    super.key,
    required this.daftarSiswa,
  });

  @override
  Widget build(BuildContext context) {
    // Menghitung jumlah seluruh siswa
    int total = daftarSiswa.length;

    // Menghitung jumlah hadir
    int hadir = daftarSiswa.where((s) => s.hadir).length;

    // Menghitung jumlah tidak hadir
    int tidakHadir = total - hadir;

    // Menghitung persentase kehadiran
    double persentase = total == 0
        ? 0
        : (hadir / total) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Kehadiran'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hasil Presensi Kelas XI RPL',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Jumlah Siswa: $total',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              'Jumlah Hadir: $hadir',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Jumlah Tidak Hadir: $tidakHadir',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Persentase Kehadiran:',
              style: TextStyle(fontSize: 18),
            ),

            Text(
              '${persentase.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            // Progress kehadiran
            LinearProgressIndicator(
              value: persentase / 100,
              minHeight: 10,
            ),

            const SizedBox(height: 25),

            // Tombol kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
