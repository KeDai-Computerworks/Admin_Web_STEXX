import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  String admin = '';

  late List<Widget> widgetOptions = <Widget>[];
  late List<String> tabName = <String>[
    "Form Daftar",
    "Pendaftar",
  ];
  @override
  void onInit() {
    if (Get.parameters["admin"] == null) {
      Get.back();
      Get.defaultDialog(title: "Ada Yang Salah");
    }

    admin = Get.parameters["admin"] ?? "";
    super.onInit();
  }
}
