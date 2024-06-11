import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  static const usersCollection = "users_2024";

  CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollection);

  String userId = '';

  @override
  void onInit() {
    if (Get.parameters["id"] == null) {
      Get.back();
      Get.defaultDialog(title: "Ada Yang Salah");
    }
    userId = Get.parameters["id"] ?? "";

    super.onInit();
  }
}
