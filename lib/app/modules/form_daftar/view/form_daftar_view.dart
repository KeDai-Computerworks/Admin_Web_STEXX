import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/input_daftar.dart';
import '../../../widgets/input_daftar_and_button.dart';
import '../../../widgets/input_dropdown.dart';
import '../controllers/form_daftar_controller.dart';

class FormDaftarView extends GetView<FormDaftarController> {
  const FormDaftarView({super.key});
  @override
  Widget build(BuildContext context) {
    InputDecoration decorationInput(String label) {
      return InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );
    }

    String tidakBolehKosong = "Tidak Boleh Kosong";

    return Scaffold(
      body: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: Get.height,
            width: Get.width * 0.5,
            child: Form(
              key: controller.formKeyDataDiri,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Email',
                      ),
                      controller: controller.emailC,
                      validator: (s) {
                        controller.validEmail(s);
                        return null;
                      },
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Nama Lengkap',
                      ),
                      controller: controller.namaLengkapC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InputDaftar(
                            decoration: decorationInput(
                              "Tempat Lahir",
                            ),
                            controller: controller.tptLahirC,
                            validator: (s) => s!.trim() != "" && s.isNotEmpty
                                ? null
                                : tidakBolehKosong,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InputDaftarAndButton(
                            decoration: decorationInput(
                              "Tanggal Lahir",
                            ),
                            controller: controller.tglLahirC,
                            onTap: () {
                              controller.selectDate(context);
                            },
                            validator: (s) => s!.trim() != "" && s.isNotEmpty
                                ? null
                                : tidakBolehKosong,
                          ),
                        ),
                      ],
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Alamat',
                      ),
                      controller: controller.alamatC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        "No.HP",
                      ),
                      controller: controller.nohpC,
                      validator: (s) {
                        String pattern =
                            r'^(\+62|62)?[\s-]?0?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$';
                        if (s!.trim() == "" && s.isEmpty) {
                          return tidakBolehKosong;
                        } else if (s.isNotEmpty) {
                          //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(s!);

                          bool mobileValid = RegExp(pattern).hasMatch(s);
                          return mobileValid ? null : "No.HP Tidak Sesuai";
                        }
                        return null;
                      },
                      isNumeric: true,
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Instagram',
                      ),
                      controller: controller.instagramC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    InputDaftarWithDropdownButton(
                      items: const [
                        "Laki-Laki",
                        'Perempuan',
                      ],
                      dropdownValue: controller.JenisKelaminC,
                      decoration: decorationInput(
                        "Jenis Kelamin",
                      ),
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    // InputDaftarWithDropdownButton(
                    //   items: const [
                    //     "A",
                    //     'B',
                    //     "AB",
                    //     'O',
                    //     'Tidak tahu',
                    //   ],
                    //   dropdownValue: controller.gologanDarahC,
                    //   decoration: decorationInput(
                    //     "Golongan Darah",
                    //   ),
                    //   validator: (s) => s!.trim() != "" && s.isNotEmpty
                    //       ? null
                    //       : tidakBolehKosong,
                    // ),
                    InputDaftarWithDropdownButton(
                      items: controller.asalkampus,
                      dropdownValue: controller.asalkampusC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                      decoration: decorationInput(
                        "Asal Kampus",
                      ),
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Jurusan',
                      ),
                      controller: controller.jurusanC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Angkatan',
                      ),
                      controller: controller.angkatanC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Semester',
                      ),
                      controller: controller.semesterC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    InputDaftar(
                      decoration: decorationInput(
                        'Alasan',
                      ),
                      controller: controller.alasanC,
                      validator: (s) => s!.trim() != "" && s.isNotEmpty
                          ? null
                          : tidakBolehKosong,
                    ),
                    
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Container(
                        width: Get.width,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black38,
                          ),
                          onPressed: controller.isLoading.isTrue
                              ? null
                              : controller.daftarFirebase,
                          child: controller.isLoading.isTrue
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Daftar",
                                  style: TextStyle(
                                    // color: Colors.grey.shade700,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
