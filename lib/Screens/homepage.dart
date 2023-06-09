import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/admin_profile.dart';
import 'package:vehicle_maintainance/Screens/map.dart';
import 'package:vehicle_maintainance/Screens/register_shop.dart';
import 'package:vehicle_maintainance/notification_service.dart';
import 'easy_search_bar.dart';
import 'home.dart';

class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  State<main_page> createState() => main_pageState();
}

class main_pageState extends State<main_page> {
  int _currentIndex = 0;
  final screens = [
    const home(),
    const easysearchbar(),
    const map(),
    const register_shop(),
    //const profile(),
  ];
  final item = [
    const Icon(Icons.home, size: 30),
    const Icon(Icons.search, size: 30),
    const Icon(Icons.location_on, size: 30),
    const Icon(Icons.how_to_reg, size: 30),
    //Icon(Icons.admin_panel_settings_outlined, size: 30),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///initialize notification
    NotifyService.initializeNotification(context);

    // FirebaseMessaging.instance.getToken().then((token) => print(token));

    ///When the app is terminated navigation works after tapping on the message
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        print(routeFromMessage);
        // var empId = _userController.emp_id.value;

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => admin_profile()));

      }
    });

    ///When the app is on foreground parsing message data
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print(notification.title);
        print(notification.body);
        print(message.data);
      }
      if(Platform.isIOS){
        NotifyService.displayNotification(message: message);
      }else{
        NotifyService.displayNotification(message: message);
      }
    });

    ///When app in background but running and navigation works after tapping on the message
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final routeFromMessage = message.data["route"];
      print(routeFromMessage);
      // var empId = _userController.emp_id.value;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => admin_profile()));

    });


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
            body: screens[_currentIndex],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              child: CurvedNavigationBar(
                //height: 65,
                items: item,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 300),
                color: const Color.fromARGB(255, 2, 145, 170),
                backgroundColor: Colors.white,
                //buttonBackgroundColor: Colors.white,
                onTap: (_currentIndex) {
                  setState(() {
                    this._currentIndex = _currentIndex;
                  });
                }
              ),
            )),
      ),
    );
  }
}
