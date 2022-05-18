import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/view_full_record.dart';
import 'manage_records.dart';

class view_record extends StatefulWidget {
  const view_record({Key? key}) : super(key: key);
  @override
  _view_recordState createState() => _view_recordState();
}

class _view_recordState extends State<view_record> {
  int carshops = 0;
  int bikeshops = 0;
  int washshops = 0;
  int batteryshops = 0;
  bool first = true;
  bool loading = true;
  void counter() async {
    carshops = 0;
    bikeshops = 0;
    washshops = 0;
    batteryshops = 0;
    var car_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .get();
    car_result.docs.forEach((res) {
      //print(res.data());
      carshops++;
      loading = false;
    });
    var bike_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .get();
    bike_result.docs.forEach((res) {
      bikeshops++;
    });
    var wash_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "wash")
        .get();
    wash_result.docs.forEach((res) {
      washshops++;
    });
    var battery_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "battery")
        .get();
    battery_result.docs.forEach((res) {
      batteryshops++;
    });
    if (first) {
      first = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      counter();
    }
    Widget tempWidget = const CircularProgressIndicator(
      strokeWidth: 3,
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
      appBar: AppBar(
        title: const Text('Records'),
        backgroundColor: Colors.indigo,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const manage_record()));
                });
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: loading == true
          ? tempWidget
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.black12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 7,
                          blurRadius: 9,
                          offset:
                              const Offset(3, 5), // changes position of shadow
                        ),
                      ],
                      color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/main.png",
                        height: 50,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "Total Car Shops",
                            style: GoogleFonts.b612(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "$carshops",
                            style: GoogleFonts.b612(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            view_full_record("car")));
                              },
                              child: Text(
                                "View Full Details >",
                                style: GoogleFonts.b612(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 7,
                          blurRadius: 9,
                          offset:
                              const Offset(3, 5), // changes position of shadow
                        ),
                      ],
                      color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/main1.png",
                        height: 50,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "Total Bike Shops",
                            style: GoogleFonts.b612(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "$bikeshops",
                            style: GoogleFonts.b612(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            view_full_record("bike")));
                              },
                              child: Text(
                                "View Full Details >",
                                style: GoogleFonts.b612(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 7,
                          blurRadius: 9,
                          offset:
                              const Offset(3, 5), // changes position of shadow
                        ),
                      ],
                      color: Colors.white),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 18,
                      ),
                      Image.asset(
                        "images/batry.png",
                        height: 50,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "Total Battery Shops",
                            style: GoogleFonts.b612(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "$batteryshops",
                            style: GoogleFonts.b612(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            view_full_record("battery")));
                              },
                              child: Text(
                                "View Full Details >",
                                style: GoogleFonts.b612(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 7,
                          blurRadius: 9,
                          offset:
                              const Offset(3, 5), // changes position of shadow
                        ),
                      ],
                      color: Colors.white),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        "images/wash.png",
                        height: 50,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "Total Wash Shops",
                            style: GoogleFonts.b612(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "$washshops",
                            style: GoogleFonts.b612(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            view_full_record("wash")));
                              },
                              child: Text(
                                "View Full Details >",
                                style: GoogleFonts.b612(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
    );
  }
}
