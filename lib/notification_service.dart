import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/admin_profile.dart';

class NotifyService {
  // static final ApprovalController _approvalController = Get.find();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initializeNotification(BuildContext context) async {
    //tz.initializeTimeZones();

    ///Ios Initialization
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload,){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => admin_profile()));
        }
    );

    ///Android Initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    final InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings, onSelectNotification: (String? payload) {

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => admin_profile()));

    });

  }

  ///Ios Permission
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  static void displayNotification({required RemoteMessage message}) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'usg_smart_office', 'usg smart office',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: message.data["two"],
    );
  }
}
