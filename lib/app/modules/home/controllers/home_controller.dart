import 'package:bitcoin_alert/app/modules/home/components/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  GetStorage storage = GetStorage('storage');
  RxInt currentIndex = 0.obs;
  RxBool bottonNavIsloading = false.obs;
  PageController pageController = PageController(initialPage: 0);

  List<CardItem> itemsCard = [
    const CardItem(title: "BTC"),
    const CardItem(
      title: "ETH",
    ),
    const CardItem(
      title: "USD",
    )
  ];

  void changePage({required int page}) async {
    print(currentIndex.value);

    bottonNavIsloading.value = true;
    Future.delayed(const Duration(milliseconds: 100), (() {
      bottonNavIsloading.value = false;
    }));

    currentIndex.value = page;
    pageController.jumpToPage(page);
  }
}
