import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({Key? key}) : super(key: key);

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
            items: controller.itemsCard,
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
                controller.startTimer();
              },
              child: const Text("Criar notificação")),
          ElevatedButton(
              onPressed: () async {
                if (controller.timer.isActive) {
                  controller.stopTimer();
                  controller.resetTimer();
                }
              },
              child: const Text("delete notificação"))
        ],
      ),
    );
  }
}
