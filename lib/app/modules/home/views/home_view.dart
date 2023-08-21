import 'package:bitcoin_alert/app/modules/home/components/bottom_bar.dart';
import 'package:bitcoin_alert/app/modules/home/views/home_tab.dart';
import 'package:bitcoin_alert/app/modules/market/views/market_view.dart';
import 'package:bitcoin_alert/app/modules/settings/views/settings_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          //key: controller.formKeys[controller.currentIndex.value],
          onPageChanged: (s) {
            print(s);
          },
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTab(),
            MarketView(),
            SettingsView(),
          ]),
      bottomNavigationBar: BottomBarHome(),
    );
  }
}
