import 'package:admin_web_ste/app/modules/details/bindings/details_binding.dart';
import 'package:get/get.dart';

import '../modules/details/views/details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: "${_Paths.HOME}/:admin",
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: "${_Paths.DETAILS}/:id",
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
  ];
}
