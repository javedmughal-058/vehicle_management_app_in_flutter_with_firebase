import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/login/login.dart';
import 'package:vehicle_maintainance/Screens/map.dart';
import 'package:vehicle_maintainance/Screens/profile.dart';
import 'package:vehicle_maintainance/Screens/register_shop.dart';
import 'package:vehicle_maintainance/Screens/searchPage.dart';

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
    SearchPage(),
    const map(),
    const register_shop(),
    const profile(),
  ];
  final item = [
    Icon(Icons.home, size: 30),
    Icon(Icons.search, size: 30),
    Icon(Icons.location_on, size: 30),
    Icon(Icons.how_to_reg, size: 30),
    Icon(Icons.admin_panel_settings_outlined, size: 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 199, 117, 11),
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
              extendBody: true,
              // backgroundColor: Colors.blue,
              appBar: AppBar(
                  title: const Text('Vehicle Maintenance'),
                  backgroundColor: Color.fromARGB(255, 2, 145, 170),
                  leading: Image.asset("images/app_icon.png")),
              body: screens[_currentIndex],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                child: CurvedNavigationBar(
                  //height: 65,
                  items: item,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 300),
                  color: Color.fromARGB(255, 2, 145, 170),
                  backgroundColor: Colors.white,
                  //buttonBackgroundColor: Colors.white,
                  onTap: (_currentIndex) => setState(() {
                    this._currentIndex = _currentIndex;
                  }),
                ),
              )),
        ),
      ),
    );
  }
}
