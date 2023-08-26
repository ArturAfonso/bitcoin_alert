import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bitcoin_alert/app/data/shared/services/blockchain_services.dart';
import 'package:bitcoin_alert/app/data/shared/services/notification_service.dart';
import 'package:bitcoin_alert/app/modules/home/components/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  GetStorage storage = GetStorage('storage');
  RxInt currentIndex = 0.obs;
  RxBool bottonNavIsloading = false.obs;
  PageController pageController = PageController(initialPage: 0);
  RxString realTimeBtcCotacao = "".obs;

  /*  List<Map<String, Object>> invalidData = [
    {"Date": "20/01/1970", "Close": 4.7002604166666675},
    {"Date": "21/01/1970", "Close": 4.281510416666668},
    {"Date": "22/01/1970", "Close": 3.9169270833333347},
  ]; */

  List<CardItem> itemsCard = [
    const CardItem(title: "BTC"),
    const CardItem(
      title: "ETH",
    ),
    const CardItem(
      title: "USD",
    )
  ];
  int seconds = 0;
  bool isActive = false;

  /* preencheInvalidData() {}

  String convertUTCtoDate(int utc) {
    // Valor UTC representando 2023-08-22 às 12:00:00
    int utcTimestamp = utc;

    // Convertendo o valor UTC para um objeto DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(utcTimestamp, isUtc: true);

    print('Valor UTC: $utcTimestamp');
    print('Data e hora convertidas: $dateTime');
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    String formattedDateTime = formatter.format(dateTime);

    return formattedDateTime;
  } */

  late Timer timer = Timer(const Duration(seconds: 1), () {
    print("late timer");
  });
  int max = 0;
  int posicao = 10;
  @override
  void onInit() {
    initCotacaoRealTime();
    super.onInit();
  }

  initCotacaoRealTime() async {
    var result = await BlockchainServices().recuperarPreco(coin: "USD");
    realTimeBtcCotacao.value = BlockchainServices().priceToCurrency(result.first.buy!);
  }

  void changePage({required int page}) async {
    print(currentIndex.value);

    bottonNavIsloading.value = true;
    Future.delayed(const Duration(milliseconds: 100), (() {
      bottonNavIsloading.value = false;
    }));

    currentIndex.value = page;
    pageController.jumpToPage(page);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      seconds++;
      if (seconds % 10 == 0) {
        // Requisição no site a cada 10 segundos
        var result = await BlockchainServices().recuperarPreco(coin: "USD");

        realTimeBtcCotacao.value = BlockchainServices().priceToCurrency(result.first.buy!);
        print("============================================================================");
        print("cotacao ${realTimeBtcCotacao.value}");
        print("============================================================================");
      }

      await NotificationService.showNotification(
        // actionType: ActionType.KeepOnTop,
        //wakeUpScreen: true,
        backgroundColor: Colors.orange.shade400,
        //largeIcon: "https://cdn-icons-png.flaticon.com/512/1797/1797383.png",
        locked: true,
        autoDismissible: false,
        id: 2,
        title: "BTC: USD${realTimeBtcCotacao.value}",
        body: "",
        //summary: "Sumario pequeno",
        //largeIcon: numebers[_posicao],
        // bigPicture: ,
        notificationLayout: NotificationLayout.BigPicture, /*  progress: max */
      );
    });
  }

  void stopTimer() {
    timer.cancel();
    NotificationService.cancelNotifications(2);
    isActive = false;
    print('timer parado');
  }

  void resetTimer() {
    timer.cancel();

    seconds = 0;
    isActive = false;
  }
}
