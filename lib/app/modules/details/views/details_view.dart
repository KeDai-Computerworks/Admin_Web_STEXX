import 'dart:developer';

import 'package:admin_web_ste/app/data/models/model_ste.dart';
import 'package:admin_web_ste/app/modules/details/controllers/details_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/utils/utils.dart';
import 'package:admin_web_ste/app/modules/home/controllers/home_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({
    super.key,
    // required this.id,
  });
  // final String id;
  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailsView'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<SteModel>>(
        stream: Utils.userLogin(controller.userId),
        builder: (ctx, s) {
          log("snapshot {s.toString()}", name: "kkk");
          log("user id ${controller.userId}", name: "kkk");
          if (s.hasData) {
            final data = s.data?.data()!;
            log(data!.nama.toString(), name: "kkk");
            return Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/bg.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Card(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Data(
                            title: 'No.Reg',
                            value: data.registrationNumber!,
                          ),
                          Data(
                            title: 'Nama',
                            value: data.nama!,
                          ),
                          Data(
                            title: 'Jenis Kelamin',
                            value: data.JenisKelamin!,
                          ),
                          Data(
                            title: 'Tempat Tanggal Lahir',
                            value: data.ttl!,
                          ),
                          Data(
                            title: 'Email',
                            value: data.email!,
                          ),
                          Data(
                            title: 'No Hp',
                            value: data.nohp!,
                          ),
                          Data(
                            title: 'ig',
                            value: data.instagram!,
                          ),
                          Data(
                            title: 'Alamat',
                            value: data.alamat!,
                          ),
                          Data(
                            title: 'Asal Kampus',
                            value: data.asalkampus!,
                          ),
                          Data(
                            title: 'jurusan',
                            value: data.jurusan!,
                          ),
                          Data(
                            title: 'angkatan',
                            value: data.angkatan!,
                          ),
                          Data(
                            title: 'semester',
                            value: data.semester!,
                          ),
                          Data(
                            title: 'Alasan',
                            value: data.alasan!,
                          ),
                          Data(
                            title: 'Foto',
                            value: data.foto!,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (homeC.admin == "kedai@gmail.com")
                            Card(
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Pembayaran",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    data.komfPembayaran == false
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black54,
                                            ),
                                            onPressed: () {
                                              Utils.firebaseFirestore
                                                  .collection(
                                                      Utils.usersCollection)
                                                  .doc(controller.userId)
                                                  .update(
                                                {
                                                  "komfPembayaran": true,
                                                },
                                              );
                                            },
                                            child: const Text("Komfirmasi"),
                                          )
                                        : const Text(
                                            "Terkomfirmasi telah membayar",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (s.hasError) {
            return Center(
              child: Text("${s.hasError}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class Data extends StatelessWidget {
  const Data({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
              width: 300,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    ':    ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
