import 'package:get/get.dart';

import '../controllers/form_daftar_controller.dart';

class FormDaftarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormDaftarController>(
      () => FormDaftarController(),
    );
  }
}
