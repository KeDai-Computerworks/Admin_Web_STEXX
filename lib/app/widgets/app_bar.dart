import 'package:admin_web_ste/app/modules/home/controllers/home_controller.dart';
import 'package:admin_web_ste/app/modules/login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appBarCostum(
  HomeController? homeController,
  TabController? controller,
  AuthController? authController,
) {
  return AppBar(
    backgroundColor: Colors.blue,
    elevation: 5,
    toolbarHeight: 90,
    actions: [
      InkWell(
        onTap: () {
          Get.defaultDialog(
            title: "peringatan",
            middleText: "Apa anda yakim ingin log-out",
            onConfirm: authController!.logout,
            onCancel: () => Get.back(),
          );
        },
        child: const Card(
          color: Colors.black54,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.logout,
            ),
          ),
        ),
      )
    ],
    title: const Text(''),
    bottom: controller != null
        ? ColoredTabBar(
            Colors.black38,
            TabBar(
              controller: controller,
              isScrollable: true,
              overlayColor: MaterialStateProperty.all(Colors.cyanAccent[50]),
              // labelColor: Colors.blue,

              tabs: List.generate(
                2,
                (index) => Tab(
                  text: homeController!.tabName[index],
                ),
              ),
            ),
          )
        : null,
  );
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.colorData, this.tabBar, {super.key});

  final Color colorData;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        color: colorData,
        child: tabBar,
      );
}
