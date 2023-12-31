import 'package:bitcoin_alert/app/data/shared/services/back_services.dart';
import 'package:bitcoin_alert/app/data/shared/services/notification_service.dart';
import 'package:bitcoin_alert/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await initializeService();

  Get.put(HomeController());

  await GetStorage.init('storage');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

//icons collor
//B9C1D9 ciza

