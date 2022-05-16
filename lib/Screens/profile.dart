import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Admin/Screens/login/login.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 350,
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70.0),
                  bottomLeft: Radius.circular(70.0)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color.fromARGB(255, 2, 145, 170),
                ],
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  "images/app_icon.png",
                  height: 300,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Vehicle Maintenance",
                  style: GoogleFonts.alike(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                )
              ],
            )),
        SizedBox(
          height: 100,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login here for Admin Side.....!",
              style: GoogleFonts.lobster(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              child: Container(
                //padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                // color: Colors.red,
                height: 70,
                width: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Color.fromARGB(255, 2, 145, 170)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.admin_panel_settings,
                      size: 50,
                      color: Colors.white,
                    ),
                    //Image.asset("images/wash.png",height: 80,width: 80,),
                    Text(
                      'Admin Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
