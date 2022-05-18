import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Screens/category.dart';
import 'package:vehicle_maintainance/Screens/detail_screen.dart';
import 'package:vehicle_maintainance/Screens/searchPage.dart';

import 'easy_search_bar.dart';

class detail extends StatefulWidget {
  String s, str;
  detail(this.s, this.str, {Key? key}) : super(key: key);

  @override
  detailState createState() => detailState(this.s, this.str);
}

class detailState extends State<detail> {
  detailState(this.shoptype, this.service) {}
  late String shoptype;
  late String service;
  List shopslist = [];
  @override
  void initState() {
    super.initState();
    fetchdatalist();
  }

  fetchdatalist() async {
    List lisofitem = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        //.orderBy("Shop Rating",descending: true)
        .where("type", isEqualTo: shoptype)
        .where("Service", isEqualTo: service)
        .where("Shop status", isEqualTo: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        lisofitem.add(result);
      });
    });
    if (lisofitem.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "No record found",
      );
      //Navigator.push(context, MaterialPageRoute(builder: (c)=> category(shoptype)));
      print("Unable to retrieve");
    } else {
      setState(() {
        shopslist = lisofitem;
        loading = false;
      });
    }
  }

  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$shoptype"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => category(shoptype)));
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => easysearchbar()));
              },
              icon: const Icon(Icons.search_outlined)),
        ],
        backgroundColor: const Color.fromARGB(255, 2, 145, 170),
      ),
      body: loading == true
          ? Center(
              // child: Text("no record found"),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Color.fromARGB(255, 247, 121, 3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Shops detail",
                      style: GoogleFonts.tajawal(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shopslist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 7,
                                blurRadius: 9,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 200.0,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${shopslist[index]["Shop Name"]}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Affordability: ${shopslist[index]["Shop Affordability"]}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RatingBar.builder(
                                    //glowColor: Colors.amber,
                                    unratedColor: Colors.amber,
                                    direction: Axis.horizontal,
                                    itemCount: shopslist[index]['Shop Rating'],
                                    itemSize: 18.0,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye,
                                size: 25,
                              ),
                              color: Colors.amber,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detail_screen(
                                          shopslist[index].id,
                                          shopslist[index].data()),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
