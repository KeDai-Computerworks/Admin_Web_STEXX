import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  final auth = Get.find<AuthController>();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailCL = TextEditingController();
  TextEditingController passwordCL = TextEditingController();

  // TextEditingController emailCL = TextEditingController(text: 'tess@gmail.com');
  // TextEditingController passwordCL = TextEditingController(text: '123123');

  var isObscureOld = true.obs;
  var isLoading = false.obs;

  void obscure() {
    isObscureOld.value = !isObscureOld.value;
  }

  void clearForm() {
    emailCL.clear();
    passwordCL.clear();
  }

  void btnLogin() {
    isLoading.value = !isLoading.value;

    if (formkey.currentState!.validate()) {
      auth.login(
        emailCL.text,
        passwordCL.text,
      );
      log("successful");
      clearForm();
      isLoading.value = !isLoading.value;

      return;
    } else {
      clearForm();
      log("UnSuccessfull");
      isLoading.value = !isLoading.value;
    }
  }

  void btnRegis() {
    isLoading.value = !isLoading.value;

    if (formkey.currentState!.validate()) {
      auth.singup(
        emailCL.text,
        passwordCL.text,
      );
      log("successful");
      clearForm();
      isLoading.value = !isLoading.value;
      return;
    } else {
      log("UnSuccessfull");
      clearForm();
      isLoading.value = !isLoading.value;
    }
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

  String? validPass(String? value) {
    if (value == null) {
      return 'cannot be blank password';
    } else if (value.length <= 6) {
      return 'Please password min 6 character';
    }
    log(passwordCL.text);
    return null;
  }
}
