
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
      id: json['id'],
      nama: json['nama'],
      noAbsen: json['noAbsen'],
    );
  }
}
