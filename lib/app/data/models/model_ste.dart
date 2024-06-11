// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class SteModel {
  final String? id;
  final String? nama;
  final String? tptLahir;
  final String? tglLahir;
  final String? ttl;
  final String? JenisKelamin;
  final String? angkatan;
  final String? jurusan;
  final String? semester;
  // final String? goldarah;
  final String? nohp;
  final String? email;
  final String? instagram;
  final String? foto;
  final String? alamat;
  final String? asalkampus;
  final String? alasan;
  final String? registrationNumber;
  final bool? komfPembayaran;
  final bool? dataDiri;

  const SteModel({
    this.id,
    this.nama,
    this.tptLahir,
    this.tglLahir,
    this.ttl,
    this.JenisKelamin,
    // this.goldarah,
    this.nohp,
    this.email,
    this.instagram,
    this.foto,
    this.alamat,
    this.asalkampus,
    this.angkatan,
    this.jurusan,
    this.semester,
    this.alasan,
    this.registrationNumber,
    this.komfPembayaran,
    this.dataDiri,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      // 'tptLahir': tptLahir,
      // 'tglLahir': tglLahir,
      'ttl': '$tptLahir, $tglLahir',
      'JenisKelamin': JenisKelamin,
      // 'goldarah': goldarah,
      'nohp': nohp,
      'email': email,
      'instagram': instagram,
      'foto': foto,
      'alamat': alamat,
      'asalkampus': asalkampus,
      'angkatan': angkatan,
      'jurusan': jurusan,
      'semester': semester,
      'alasan': alasan,
      'registrationNumber': registrationNumber,
      'komfPembayaran': komfPembayaran,
      'dataDiri': dataDiri,
    };
  }

  factory SteModel.fromMap(Map<String, dynamic> map, String id) {
    return SteModel(
      id: id,
      nama: map['nama'] != null ? map['nama'] as String : "",
      tptLahir: map['tptLahir'] != null ? map['tptLahir'] as String : "",
      tglLahir: map['tglLahir'] != null ? map['tglLahir'] as String : "",
      ttl: map['ttl'] != null ? map['ttl'] as String : "",
      JenisKelamin:
          map['JenisKelamin'] != null ? map['JenisKelamin'] as String : "",
      // goldarah: map['goldarah'] != null ? map['goldarah'] as String : "",
      nohp: map['nohp'] != null ? map['nohp'] as String : "",
      email: map['email'] != null ? map['email'] as String : "",
      instagram: map['instagram'] != null ? map['instagram'] as String : "",
      foto: map['foto'] != null ? map['foto'] as String : "",
      alamat: map['alamat'] != null ? map['alamat'] as String : "",
      asalkampus: map['asalkampus'] != null ? map['asalkampus'] as String : "",
      angkatan: map['angkatan'] != null ? map['angkatan'] as String : "",
      jurusan: map['jurusan'] != null ? map['jurusan'] as String : "",
      semester: map['semester'] != null ? map['semester'] as String : "",
      alasan: map['alasan'] != null ? map['alasan'] as String : "",
      registrationNumber: map['registrationNumber'] != null
          ? map['registrationNumber'] as String
          : "",
      komfPembayaran:
          map['komfPembayaran'] != null ? map['komfPembayaran'] as bool : false,
      dataDiri: map['dataDiri'] != null ? map['dataDiri'] as bool : false,
    );
  }

  factory SteModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    Map<String, dynamic> json = data.data()!;
    return SteModel.fromMap(json, data.id);
  }
}
