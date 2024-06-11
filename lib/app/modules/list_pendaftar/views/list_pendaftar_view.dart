import 'dart:developer';

import 'package:admin_web_ste/app/data/models/model_ste.dart';
import 'package:admin_web_ste/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/list_pendaftar_controller.dart';

class ListPendaftarView extends GetView<ListPendaftarController> {
  const ListPendaftarView({super.key});
  @override
  Widget build(BuildContext context) {
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
        child: controller.obx(
          (state) {
            controller.usersListData.sort((a, b) {
              return b.registrationNumber!.compareTo(a.registrationNumber!);
            });

            log(state?.length.toString() ?? "adsadas");
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state?.length ?? 0,
              itemBuilder: (context, index) {
                SteModel? data = state?[index];
                return Center(
                  child: SizedBox(
                    width: Get.width * 0.5,
                    child: CardUser(
                      data: data!,
                      onTap: () {
                        Get.toNamed(
                          "${Routes.DETAILS}/${data.id}",
                          // arguments: data.id,
                        );
                      },
                    ),
                  ),
                );
                // return null;
              },
            );
          },
          onEmpty: const Center(
            child: Text("Masih Kosong"),
          ),
          onError: (error) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class CardUser extends GetView<ListPendaftarController> {
  const CardUser({
    super.key,
    required this.data,
    required this.onTap,
  });
  final SteModel data;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.registrationNumber!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nama!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.email!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const Text(
                    "pembayaran",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  data.komfPembayaran == false
                      ? const Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
