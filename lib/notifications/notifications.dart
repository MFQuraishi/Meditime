import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  /// making a singleton Class pattern
  static final Notifications _notification = Notifications._internal();
  Notifications._internal();
  factory Notifications() {
    return _notification;
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    "channelID",
    "channelName",
    "channelDescription",
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
  );

  Future init() async {
    final AndroidInitializationSettings settingsAndroid =
        new AndroidInitializationSettings("clock");
    final InitializationSettings initializationSettings =
        new InitializationSettings(android: settingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    //TODO: what will happen when a user taps on a notification.
    print("tapped on a notification which has a payload: " + "${payload}");
  }

  // Future<void> showNotification() async {
  //   await flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Medicine Time",
  //       "take your medicines",
  //       NotificationDetails(android: androidNotificationDetails),
  //       payload: "first notification");
  // }

  Future<void> scheduleNotification(time, name) async {
    await flutterLocalNotificationsPlugin.schedule(
        1,
        name,
        "take your medicine",
        time,
        NotificationDetails(android: androidNotificationDetails),
        payload: "scheduled notification");
  }
}