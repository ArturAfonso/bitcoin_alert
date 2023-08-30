import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bitcoin_alert/app/data/shared/services/blockchain_services.dart';
import 'package:bitcoin_alert/app/data/shared/services/notification_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeTab extends StatefulWidget {
  HomeController controller = Get.find();
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String text = "stop service";
  String realTimeBtcCotacao = "";
  int seconds = 0;
  bool _isActive = false;
  Timer? _timer;
  final int _max = 0;
  final int _posicao = 10;

  initCotacaoRealTime() async {
    var result = await BlockchainServices().recuperarPreco(coin: "USD");
    realTimeBtcCotacao = BlockchainServices().priceToCurrency(result.first.buy!);
  }

  void _startTimer(int value) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      /*   setState(() {
        seconds++;

        
      }); */
      // print(seconds);
      seconds++;

      if (seconds % 10 == 0) {
        // Requisição no site a cada 10 segundos
        var result = await BlockchainServices().recuperarPreco(coin: "USD");
        widget.controller.initCotacaoRealTime();
        realTimeBtcCotacao = BlockchainServices().priceToCurrency(result.first.buy!);
        print("============================================================================");
        print("cotacao $realTimeBtcCotacao");
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
        title: "BTC: USD$realTimeBtcCotacao",
        body: "",
        //summary: "Sumario pequeno",
        //largeIcon: numebers[_posicao],
        // bigPicture: ,
        notificationLayout: NotificationLayout.BigPicture, /*  progress: max */
      );

      /*  if (_max == 100) {
        NotificationService.cancelNotifications(2);
        _stopTimer();
        await NotificationService.showNotification(
            wakeUpScreen: true,
            locked: false,
            autoDismissible: true,
            id: 2,
            title: "Atendimento",
            body: "Chegou sua vez, dirija-se ao consultório",
            payload: {
              'navigate': 'true',
            },
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Unimed_box_logo.svg/1200px-Unimed_box_logo.svg.png');
      } */
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isActive = false;
      print('timer parado');
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      seconds = 0;
      _isActive = false;
    });
  }
//------------------------------------------------------------------------------

  @override
  void initState() {
    initCotacaoRealTime();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //_stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.size.width, 100),
        child: SizedBox(
          height: 300,
          // color: Colors.grey,
          child: Stack(
            children: const [
              Positioned(
                left: 40,
                bottom: 10,
                child: Text(
                  "Portfolio",
                  style: TextStyle(fontSize: 36, fontFamily: "SF_Pro_display"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              //aspectRatio: 16 / 6,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            ),
            items: widget.controller.itemsCard,
          ),
          /* Container(
            margin: const EdgeInsets.only(top: 10),
            width: 350,
            height: 300,
            child: Chart(
              data: controller.invalidData,
              variables: {
                'Date': Variable(
                  accessor: (Map map) => map['Date'] as String,
                  scale: OrdinalScale(tickCount: 5),
                ),
                'Close': Variable(
                  accessor: (Map map) => (map['Close'] ?? double.nan) as num,
                ),
              },
              marks: [
                AreaMark(
                  shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                  color: ColorEncode(value: Defaults.colors10.first.withAlpha(80)),
                ),
                LineMark(
                  shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                  size: SizeEncode(value: 0.5),
                ),
              ],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
              selections: {
                'touchMove': PointSelection(
                  on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
                  dim: Dim.x,
                )
              },
              tooltip: TooltipGuide(
                followPointer: [false, true],
                align: Alignment.topLeft,
                offset: const Offset(-20, -20),
              ),
              crosshair: CrosshairGuide(followPointer: [false, true]),
            ),
          ), */
          ElevatedButton(
              onPressed: () async {
                //var teste = await BlockchainServices().recuperarPreco();
                //print(teste);
                //widget.controller.startTimer();
                initCotacaoRealTime();
                _startTimer(0);
              },
              child: const Text("Criar notificação")),
          ElevatedButton(
              onPressed: () {
                print("cancelar notificaçoes");
                if (_timer != null) {
                  print(_timer!.isActive);
                  if (_timer!.isActive) {
                    _stopTimer();
                    _timer!.cancel();
                    NotificationService.cancelNotifications(2);
                    NotificationService.cancelAllNotifications();
                  } else {
                    NotificationService.cancelAllNotifications();
                  }
                } else {
                  print("timer nao iniciado");
                }
              },
              /* _timer != null
                  ? _timer!.isActive
                      ? () {
                          _stopTimer();
                          NotificationService.cancelAllNotifications();
                        }
                      : () {
                          NotificationService.cancelAllNotifications();
                        }
                  : () {}, */
              /* () async {
                if (widget.controller.timer.isActive) {
                  widget.controller.stopTimer();
                  widget.controller.resetTimer();
                }
              }, */
              child: const Text("delete notificação")),
          const Divider(),
          ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsForeground');
              },
              child: const Text("Foreground Service")),
          ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsBackground');
              },
              child: const Text("Background Service")),
          ElevatedButton(
              onPressed: () async {
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke('stopService');
                } else {
                  service.startService();
                }
                if (!isRunning) {
                  text = "stop service";
                } else {
                  text = 'start service';
                }
                setState(() {});
              },
              child: Text(text)),
        ],
      ),
    );
  }
}
