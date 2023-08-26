import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bitcoin_alert/app/modules/home/views/second_screen.dart';
import 'package:bitcoin_alert/main.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/bitcoin',
        [
          NotificationChannel(
              channelGroupKey: 'high_importance_channel',
              channelKey: 'high_importance_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color.fromARGB(255, 91, 127, 104),
              ledColor: Colors.red,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              locked: true),
          NotificationChannel(
            channelGroupKey: 'no_lock_channel',
            channelKey: 'no_lock_channel',
            channelName: 'no lock notifications',
            channelDescription: 'Notification channel no locked',
            defaultColor: const Color.fromARGB(255, 91, 127, 104),
            ledColor: Colors.red,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true, /*  locked: true */
          ),
          NotificationChannel(
            channelGroupKey: 'my_foreground',
            channelKey: 'my_foreground',
            channelName: 'my_foreground',
            channelDescription: 'my_foreground',
            defaultColor: Colors.orange,
            ledColor: Colors.red,
            importance: NotificationImportance.Low,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true, /*  locked: true */
          )
        ],
        channelGroups: [
          NotificationChannelGroup(channelGroupKey: 'high_importance_channel', channelGroupName: 'Group 1'),
          NotificationChannelGroup(channelGroupKey: 'no_lock_channel', channelGroupName: 'Group 2'),
          NotificationChannelGroup(channelGroupKey: 'my_foreground', channelGroupName: 'Group 3'),
        ],
        debug: true);

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  //use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  //use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  //use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  //use this method to detect when the user taps on a notificaont or action button
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');

    final payload = receivedAction.payload ?? {};
    if (payload['navigate'] == 'true') {
      print("Vindo da notificação");
      MainApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => const SecondScreen()));
    }
  }

  static Future<void> showNotification(
      {final int? id,
      required final String title,
      required final String body,
      final String? summary,
      final Map<String, String>? payload,
      final ActionType actionType = ActionType.Default,
      final NotificationLayout notificationLayout = NotificationLayout.Default,
      final NotificationCategory? category,
      final String? bigPicture,
      final String? largeIcon,
      final String? channelKey,
      final List<NotificationActionButton>? actionButtons,
      final bool scheduled = false,
      final bool? autoDismissible,
      final bool? criticalAlert,
      final bool? displayOnBackground,
      final bool? displayOnForeground,
      final bool? wakeUpScreen,
      final bool? locked,
      final int? interval,
      final int? progress,
      final Color? backgroundColor}) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            roundedLargeIcon: true,
            backgroundColor: backgroundColor,
            locked: locked ?? false,
            autoDismissible: autoDismissible ?? true,
            criticalAlert: criticalAlert ?? false,
            displayOnBackground: displayOnBackground ?? true,
            displayOnForeground: displayOnForeground ?? true,
            largeIcon: largeIcon,
            // hideLargeIconOnExpand: true,
            ticker: "ticker",
            progress: progress,
            id: id ?? -1,
            channelKey: channelKey ?? 'high_importance_channel',
            title: title,
            body: body,
            actionType: actionType,
            notificationLayout: notificationLayout,
            summary: summary,
            category: category,
            payload: payload,
            bigPicture: bigPicture,
            wakeUpScreen: wakeUpScreen ?? false),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }

  static Future<void> cancelNotifications(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
