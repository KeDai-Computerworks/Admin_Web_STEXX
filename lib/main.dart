import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/login/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final AuthController auth = Get.put(AuthController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
      stream: auth.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          log(snapshot.data.toString());
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Admin Ste",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? "${Routes.HOME}/${snapshot.data!.email}"
                    : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
    // GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Admin Ste",
    //   initialRoute: AppPages.INITIAL,
    //   getPages: AppPages.routes,
    // ),
  );
}
