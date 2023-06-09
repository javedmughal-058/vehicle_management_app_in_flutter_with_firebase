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
  int washshops1 = 0;
  bool first = true;
  bool loading = true;
  void _deleteAll() async {
    await FirebaseFirestore.instance.collection('shops').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    // await FirebaseFirestore.instance
    //     .collection("shops")
    //     .doc()
    //     .delete()
    //     .then((_) {
    //   print("Deleted success!");
    // }).catchError((error) => print('Delete failed: $error'));
  }

  void counter() async {
    carshops = 0;
    bikeshops = 0;
    washshops = 0;
    batteryshops = 0;
    washshops1 = 0;
    var car_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .get();
    car_result.docs.forEach((res) {
      //print(res.data());
      carshops++;
    });
    loading = false;
    var bike_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "bike")
        .get();
    bike_result.docs.forEach((res) {
      bikeshops++;
    });
    loading = false;
    var wash_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "wash")
        .get();
    wash_result.docs.forEach((res) {
      washshops++;
    });
    loading = false;
    var wash_result1 = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "car")
        .where("Service", isEqualTo: "wash")
        .get();
    wash_result.docs.forEach((res) {
      washshops1++;
    });
    washshops = washshops + washshops1;

    loading = false;

    var battery_result = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: "battery")
        .get();
    battery_result.docs.forEach((res) {
      batteryshops++;
    });
    loading = false;

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
        actions: [
          PopupMenuButton(
            //  color: Colors.yellowAccent,
            elevation: 20,

            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.report_problem,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Delete All Record"),
                  ],
                ),
                value: 1,
              ),
            ],
            onSelected: (value) async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Alert",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        content: const Text(
                            "Do you want to delete all Records?",
                            style: TextStyle(color: Colors.black)),
                        actions: [
                          GestureDetector(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: const Text("No",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                          GestureDetector(
                             onTap:(){
                               setState(() {
                                 //loading = true;
                                 _deleteAll();
                                 Navigator.of(context).pop();
                                 // loading == false
                                 //     ? Center(
                                 //         child: Container(
                                 //           //width: 120,height: 120,
                                 //           child:
                                 //               const CircularProgressIndicator(
                                 //             // backgroundColor: Colors.grey,
                                 //             strokeWidth: 7,
                                 //             valueColor:
                                 //                 AlwaysStoppedAnimation<Color>(
                                 //                     Colors.blue),
                                 //           ),
                                 //         ),
                                 //       )
                                 //     :
                                 counter();
                               });
                             },
                              child: const Text("Yes",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))),
                        ],
                        elevation: 24.0,
                        backgroundColor: Colors.white);
                  });
            },
          ),
        ],
      ),
      body: loading == true
          ? tempWidget
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  "Total Shops: ${carshops + bikeshops + batteryshops + washshops}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.black12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 4,
                          blurRadius: 3,
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 4,
                          blurRadius: 3,
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 4,
                          blurRadius: 3,
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 4,
                          blurRadius: 3,
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
              ],
            ),
    );
  }
}
