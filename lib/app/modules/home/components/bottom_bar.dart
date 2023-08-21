import 'package:bitcoin_alert/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomBarHome extends StatelessWidget {
  BottomBarHome({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((() => BottomNavigationBar(
          elevation: 15,
          selectedItemColor: Colors.yellowAccent,
          selectedIconTheme: const IconThemeData(size: 32),
          unselectedIconTheme: const IconThemeData(size: 32),
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(color: Colors.red, fontSize: 12),
          unselectedLabelStyle: const TextStyle(color: Colors.green, fontSize: 12),
          currentIndex: controller.currentIndex.value,
          onTap: (x) {
            controller.changePage(page: x);
          },
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: Image.asset("assets/icons/casa.png",
                    height: 32,
                    color: controller.currentIndex.value == 0
                        ? HexColor("F6543E") //AppSettings.of(context)!.settings.colorPrimaryLight
                        : HexColor("B9C1D9"))),
            BottomNavigationBarItem(
                label: "",
                icon: Image.asset("assets/icons/dinheiro-de-volta.png",
                    height: 34,
                    color: controller.currentIndex.value == 1
                        ? HexColor("F6543E") //AppSettings.of(context)!.settings.colorPrimaryLight
                        : HexColor("B9C1D9"))),
            BottomNavigationBarItem(
                label: "",
                icon: Image.asset("assets/icons/do-utilizador.png",
                    height: 32,
                    color: controller.currentIndex.value == 2
                        ? HexColor("F6543E") //AppSettings.of(context)!.settings.colorPrimaryLight
                        : HexColor("B9C1D9"))),

            /*    BottomNavigationBarItem(
                label: "Financeiro",
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                      height: 35,
                      width: Get.size.width / 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30.0),
                          color: (controller.currentIndex.value == 4 && controller.bottonNavIsloading.value == true)
                              ? Colors.yellow //AppSettings.of(context)!.settings.colorPrimaryLight
                              : Colors.transparent),
                      child: const Icon(Icons.auto_graph_outlined)),
                )), */
          ],
        )));
  }
}
