import 'package:flutter/material.dart';

import 'admin_home.dart';
import 'admin_profile.dart';
import 'manage_records.dart';

class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  _main_pageState createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  int _currentIndex = 0;
  final tabs = [
    admin_home(),
    manage_record(),
    admin_profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Vehicle Maintenance'),
            backgroundColor: Colors.indigo,
            leading: Image.asset("images/main.png")),
        body: tabs[_currentIndex],
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            fixedColor: Colors.white,
            backgroundColor: Colors.indigo,
            iconSize: 22,
            selectedFontSize: 17,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Record',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ));
  }
}
