import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/model_ste.dart';

class FormDaftarController extends GetxController {
  final formKeyDataDiri = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final namaLengkapC = TextEditingController();
  final tptLahirC = TextEditingController();
  final tglLahirC = TextEditingController();
  final ttlC = TextEditingController();
  final alamatC = TextEditingController();
  final nohpC = TextEditingController();
  final instagramC = TextEditingController();
  final alasanC = TextEditingController();
  final JenisKelaminC = 'Laki-Laki'.obs;
  final gologanDarahC = 'A'.obs;
  final asalkampusC = "Universitas Dipa Makassar".obs;
  final jurusanC = TextEditingController();
  final angkatanC = TextEditingController();
  final semesterC = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Rx<File?> pickedImage = Rx<File?>(null);
  final storageRef = FirebaseStorage.instance.ref();

  final isLoading = false.obs;

  final firebaseFirestore = FirebaseFirestore.instance;
  static const usersCollection = "users_2024";
  CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollection);

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  Future<void> uploadImage(String userId) async {
    if (pickedImage.value != null) {
      try {
        final Reference ref =
            storageRef.child('users/$userId/profile_picture.jpg');
        await ref.putFile(pickedImage.value!);
        Get.snackbar('Success', 'Image uploaded successfully');
      } on FirebaseException catch (e) {
        Get.snackbar('Error', 'Failed to upload image: ${e.message}');
      }
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<int> lengt() async {
    final panjangData = await users.get();
    log(panjangData.size.toString());
    return panjangData.size;
  }

  Future<void> updateRegistrationCounter() async {
    try {
      // Mendapatkan referensi dokumen di koleksi registration-counter
      DocumentReference counterDocRef = FirebaseFirestore.instance
          .collection('registration-counter')
          .doc('lastRegistrationNumber');

      // Mendapatkan data dokumen
      DocumentSnapshot snapshot = await counterDocRef.get();

      // Mendapatkan nilai lastRegistrationNumber dari snapshot
      int lastRegistrationNumber = snapshot.exists
          ? (snapshot.data() as Map<String, dynamic>)['number'] as int? ?? 0
          : 0;

      // Menambah 1 pada lastRegistrationNumber
      int updatedNumber = lastRegistrationNumber + 1;

      // Memperbarui nilai lastRegistrationNumber di dokumen tersebut
      await counterDocRef.set({'number': updatedNumber});
    } catch (e) {
      log('Error updating registration counter: $e');
    }
  }

  Future daftarFirebase() async {
    isLoading.value = !isLoading.value;
    if (formKeyDataDiri.currentState!.validate()) {
      log("onClik", name: "lll");

      int panjangListUser = await lengt() + 1;
      String registrationNumber = panjangListUser.toString().padLeft(3, '0');
      log(registrationNumber, name: "lll");

      // Memperbarui nomor registrasi
      await updateRegistrationCounter();

      users.doc(emailC.text).set(
            SteModel(
              nama: namaLengkapC.text,
              tptLahir: tptLahirC.text,
              tglLahir: tglLahirC.text,
              JenisKelamin:
                  JenisKelaminC.value == "Laki-Laki" ? "male" : "female",
              alasan: alasanC.text,
              email: emailC.text,
              instagram: instagramC.text,
              asalkampus: asalkampusC.value,
              jurusan: jurusanC.text,
              angkatan: angkatanC.text,
              semester: semesterC.text,
              alamat: alamatC.text,
              nohp: nohpC.text,
              registrationNumber: registrationNumber,
              komfPembayaran: false,
            ).toMap(),
          );

      final dataRegis = await users
          .where(
            "nomorReg",
            isEqualTo: registrationNumber,
          )
          .get();
      if (dataRegis.size != 0) {
        Get.defaultDialog(
          title: "info",
          middleText: "${emailC.text} ini telah berhasil di daftarkan",
          content: Text(
            "dengan No.Reg $registrationNumber",
          ),
          onConfirm: () => Get.back(),
        );
        clearForm();
        isLoading.value = !isLoading.value;
      } else {
        Get.defaultDialog(
          title: "info",
          middleText: "${emailC.text} tidak berhasil di daftarkan",
          content: const Text(
            "Daftarkan kembali",
          ),
          onConfirm: () => Get.back(),
        );
        clearForm();
        isLoading.value = !isLoading.value;
      }
    } else {
      isLoading.value = !isLoading.value;
    }
  }

  void clearForm() {
    emailC.clear();
    namaLengkapC.clear();
    tptLahirC.clear();
    tglLahirC.clear();
    nohpC.clear();
    instagramC.clear();
    alamatC.clear();
    alasanC.clear();
    jurusanC.clear();
    angkatanC.clear();
    semesterC.clear();
  }

  String? validEmail(String? value) {
    if (value!.isEmpty) {
      return 'cannot be blank email';
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return 'Please a valid Email';
    }
    return null;
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.utc(2001), // Refer step 1
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.now()) {
      String year = picked.year.toString();
      String month = picked.month.toString();
      String day = picked.day.toString();
      tglLahirC.text = "$day-$month-$year";
    }
  }

  final asalkampus = [
    "Universitas Dipa Makassar",
    "Universitas Hasanuddin",
    "Universitas Islam Negeri Alauddin Makassar",
    "Universitas Negeri Makassar",
    "Universitas Bosowa",
    "Universitas Atma Jaya",
    "Universitas Kristen Indonesia Paulus",
    "Universitas Fajar",
    "Universitas Muhammadiyah Makassar",
    "Universitas Teknologi Sulawesi",
    "Universitas Islam Makassar",
    "Universitas Megarezky",
    "Politeknik Negeri Ujung Pandang",
    "Politeknik Negeri Media Kreatif",
    "Politeknik Informatika Makassar",
    "Politeknik ATI Makassar",
    "STMIK Akba Makassar",
    "STMIK Handayani Makassar",
    "STMIK Kharisma Makassar",
    "STMIK Profesional Makassar",
    "STIM Nitro Makassar",
    "STKIP YPUP Makassar",
    "STIE Nobel Indonesia",
    "STIM LPI Makassar",
    "Kampus Lain",
    "Belum Kuliah",
  ];
}
