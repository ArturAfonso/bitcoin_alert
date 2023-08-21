import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/market_controller.dart';

class MarketView extends GetView<MarketController> {
  const MarketView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MarketView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MarketView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
