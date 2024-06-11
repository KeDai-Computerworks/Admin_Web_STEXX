import 'package:admin_web_ste/app/modules/form_daftar/view/form_daftar_view.dart';
import 'package:admin_web_ste/app/modules/list_pendaftar/views/list_pendaftar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_bar.dart';
import '../../login/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin, RestorationMixin {
  final controller = Get.find<HomeController>();
  final authController = Get.find<AuthController>();
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      appBar: appBarCostum(controller, tabController, authController),
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[
          FormDaftarView(),
          ListPendaftarView(),
        ],
      ),
    );
  }

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String? get restorationId => 'tab_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }
}
