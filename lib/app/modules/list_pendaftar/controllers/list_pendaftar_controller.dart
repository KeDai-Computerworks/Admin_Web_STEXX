import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_web_ste/app/data/models/model_ste.dart';
import 'package:get/get.dart';

class ListPendaftarController extends GetxController
    with StateMixin<List<SteModel>> {
  final firebaseFirestore = FirebaseFirestore.instance;
  static const usersCollection = "users_2024";
  var usersListData = <SteModel>[];
  // RxList<SteModel> usersList = RxList<SteModel>();

  Stream<QuerySnapshot<Map<String, dynamic>>> get listUserStream =>
      firebaseFirestore.collection(usersCollection).snapshots();

  @override
  void onInit() {
    listUserStream.listen((event) {
      log(event.size.toString());
      if (event.size == 0) {
        log("empty", name: "data");
        change(null, status: RxStatus.empty());
      } else {
        log("ada data", name: "data");
        usersListData = List.generate(event.docs.length, (index) {
          final data = event.docs[index];
          return SteModel.fromDocumentSnapshot(data);
        });

        log(usersListData.length.toString());

        change(usersListData, status: RxStatus.success());
      }
    });
    // fetchUsers();

    super.onInit();
  }

  // void fetchUsers() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await firebaseFirestore.collection(usersCollection).get();
  //     usersList.value = querySnapshot.docs
  //         .map((doc) => SteModel.fromDocumentSnapshot(doc))
  //         .toList();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
