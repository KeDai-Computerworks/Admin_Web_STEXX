import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:admin_web_ste/app/widgets/input_custom.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(-2, 0),
            image: AssetImage(
              "assets/images/bg.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 370,
            width: 500,
            padding: const EdgeInsets.all(
              30,
            ),
            child: Center(
              child: Card(
                color: Colors.white,
                child: Form(
                  key: controller.formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFieldCustom(
                          label: 'Email',
                          hint: 'Your email',
                          controller: controller.emailCL,
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.validEmail,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(
                          () => TextFieldCustom(
                            label: 'Password',
                            hint: 'Your password',
                            keyboardType: TextInputType.text,
                            controller: controller.passwordCL,
                            obscureText: controller.isObscureOld.value,
                            icon: GestureDetector(
                              onTap: controller.obscure,
                              child: Icon(
                                !controller.isObscureOld.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 26,
                                color: Colors.black54,
                              ),
                            ),
                            validator: controller.validPass,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(
                          () => SizedBox(
                            width: Get.width,
                            height: 50,
                            // margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: controller.isLoading.isTrue
                                  ? null
                                  : controller.btnLogin,
                              child: controller.isLoading.isTrue
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
