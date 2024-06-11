import 'package:admin_web_ste/app/modules/form_daftar/controllers/form_daftar_controller.dart';
import 'package:admin_web_ste/app/modules/list_pendaftar/controllers/list_pendaftar_controller.dart';
import 'package:get/get.dart';

import '../../login/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put<FormDaftarController>(
      FormDaftarController(),
    );
    Get.put<ListPendaftarController>(
      ListPendaftarController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
