import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:intl/intl.dart';

const notificationChannelId = 'high_importance_channel';

// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 888;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  int count = 0;
  double cotacao = 0.0;
  String data = getCurrentFormattedDateTime();
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      print('setAsForeground');
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      print('setAsBackground');
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    count++;
    data = getCurrentFormattedDateTime();
    /*   if (cotacao < 27672.3) {
      print("--------------------menor-------------------------");
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
    } else {
      print("=================NAO===============");
    } */

    if (count == 1) {
      data = getCurrentFormattedDateTime();
      cotacao = await getCotacao();
    } else if (count % 10 == 0) {
      data = getCurrentFormattedDateTime();
      cotacao = await getCotacao();
    }
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Cotação em $data",
          content: "1 BTC = ${priceToCurrency(cotacao)}",
        );
      }
    }

    //perfom some operations on background which in not noticeable to the user everytime
    print("brackground service running");
    service.invoke('update');
  });
}

String getCurrentFormattedDateTime() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yy').format(now);
  String formattedTime = DateFormat('HH:mm:ss').format(now);
  return '$formattedDate $formattedTime';
}

Future<double> getCotacao() async {
  double resultado = 0.0;
  String url = "https://blockchain.info/ticker";
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> retorno = json.decode(response.body);

    resultado = retorno["USD"]['buy'];

    return resultado;
  } else {
    return resultado;
  }
}

String priceToCurrency(double price) {
  NumberFormat numberFormat = NumberFormat.currency(
    symbol: "\$ ",
  );
  var value = numberFormat.format(price);

  return numberFormat.format(price);
}
