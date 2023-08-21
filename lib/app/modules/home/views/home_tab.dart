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
        child: Container(
          height: 300,
          color: Colors.grey,
          child: Stack(
            children: const [
              Positioned(
                left: 20,
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
          )
        ],
      ),
    );
  }
}
