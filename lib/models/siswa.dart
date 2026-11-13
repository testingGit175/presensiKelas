class Siswa {
  int id;
  String nama;
  int noAbsen;
  bool hadir;

  Siswa({
    required this.id,
    required this.nama,
    required this.noAbsen,
    this.hadir = false,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      id: json['id'] as int,
      nama: json['nama'] as String,
      noAbsen: json['noAbsen'] as int,
      // Field "hadir" belum ada di siswa.json, sehingga default-nya false.
      hadir: json['hadir'] == true,
    );
  }
}
