import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// class adminside extends StatelessWidget {
//   final navigatorkey = GlobalKey<NavigatorState>();
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       navigatorKey: navigatorkey,
//       home: const admin_home(),
//     );
//   }
// }

class admin_home extends StatefulWidget {
  const admin_home({Key? key}) : super(key: key);

  @override
  _admin_homeState createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  bool loading = true;

  int car_m = 0,
      car_e = 0,
      car_O = 0,
      car_dp = 0,
      car_t = 0,
      car_s = 0,
      car_air = 0;
  int bike_m = 0, bike_e = 0, bike_O = 0, bike_dp = 0, bike_t = 0, bike_s = 0;
  int battery = 0, wash = 0;
  final listOfServices = [
    "Mechanical",
    "Oil Change",
    "Electrical",
    "Denting and Painting",
    "Tire Shop",
    "Spare Parts"
  ];
  final type = ["car", "bike", "wash"];
  void initstate() {
    super.dispose();
    //counter();
  }

  void counter() async {
    var car_1 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "mechanical")
        .get();
    car_1.docs.forEach((res) {
      // print(res.data());
      car_m++;
      loading = false;
    });
    var car_2 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "electrical")
        .get();
    car_2.docs.forEach((res) {
      //print(res.data());
      car_e++;
    });
    var car_3 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "oil change")
        .get();
    car_3.docs.forEach((res) {
      //print(res.data());
      car_O++;
    });
    var car_4 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "denting and painting")
        .get();
    car_4.docs.forEach((res) {
      //print(res.data());
      car_dp++;
    });
    var car_5 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "tire")
        .get();
    car_5.docs.forEach((res) {
      //print(res.data());
      car_t++;
    });
    var car_6 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "spare parts")
        .get();
    car_6.docs.forEach((res) {
      //print(res.data());
      car_s++;
    });
    var car_7 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "spare parts")
        .get();
    car_7.docs.forEach((res) {
      //print(res.data());
      car_air++;
    });

    var b_1 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .where("Service", isEqualTo: "mechanical")
        .get();
    b_1.docs.forEach((res) {
      //print(res.data());
      bike_m++;
    });
    var b_2 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .where("Service", isEqualTo: "electrical")
        .get();
    b_2.docs.forEach((res) {
      //print(res.data());
      bike_e++;
    });
    var b_3 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .where("Service", isEqualTo: "oil change")
        .get();
    b_3.docs.forEach((res) {
      //print(res.data());
      bike_O++;
    });
    var b_4 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .where("Service", isEqualTo: "denting and painting")
        .get();
    b_4.docs.forEach((res) {
      //print(res.data());
      bike_dp++;
    });
    var b_5 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .where("Service", isEqualTo: "tire")
        .get();
    b_5.docs.forEach((res) {
      //print(res.data());
      bike_t++;
    });
    var b_6 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .where("Service", isEqualTo: "spare parts")
        .get();
    b_6.docs.forEach((res) {
      //print(res.data());
      bike_s++;
    });

    var battery_r = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "battery")
        .get();
    battery_r.docs.forEach((res) {
      //print(res.data());
      battery++;
    });

    var wash_r = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "wash")
        .get();
    wash_r.docs.forEach((res) {
      //print(res.data());
      wash++;
    });
    if (first) {
      first = false;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  bool first = true;
  @override
  Widget build(BuildContext context) {
    if (first) {
      counter();
    }
    Widget tempWidget = const CircularProgressIndicator(
      strokeWidth: 3,
      backgroundColor: Color.fromARGB(255, 247, 121, 3),
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
    if (loading) {
      tempWidget = const Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: Color.fromARGB(255, 247, 121, 3),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      );
    } else {
      tempWidget = const Center(); //EmptyWidget
    }
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              //mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  // padding: EdgeInsets.all(10),
                  height: 570,
                  width: 340,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.indigo,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "images/main.png",
                        height: 100,
                      ),
                      Text(
                        "Car Shops Details",
                        style: GoogleFonts.merriweather(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        height: 360,
                        width: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: const Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: loading
                            ? tempWidget
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Mechanical Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_m",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Electrical Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_e",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Oil Change Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_O",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Denting & Painting Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_dp",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Tyre Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_t",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Spare Parts Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_s",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "air conditioner",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$car_air",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  height: 570,
                  width: 340,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.indigo,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "images/main1.png",
                        height: 100,
                      ),
                      Text(
                        "Bike Shops Details",
                        style: GoogleFonts.merriweather(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        height: 360,
                        width: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: loading
                            ? tempWidget
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Mechanical Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$bike_m",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Electrical Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$bike_e",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Oil Change Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$bike_O",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Denting & Painting Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$bike_dp",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Tyre Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$bike_t",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        //SizedBox(width: 20,),
                                        Text(
                                          "Spare Parts Shops",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "$bike_s",
                                          style: GoogleFonts.merriweather(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  height: 570,
                  width: 340,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.indigo,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "images/batry.png",
                        height: 100,
                      ),
                      Text(
                        "Battery/Wash",
                        style: GoogleFonts.merriweather(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        height: 360,
                        width: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: loading
                            ? tempWidget
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      //SizedBox(width: 20,),
                                      Text(
                                        "Battery Shops",
                                        style: GoogleFonts.merriweather(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "$battery",
                                        style: GoogleFonts.merriweather(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      //SizedBox(width: 20,),
                                      Text(
                                        "Wash Shops",
                                        style: GoogleFonts.merriweather(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "$wash",
                                        style: GoogleFonts.merriweather(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ])),
    ));
  }
}
