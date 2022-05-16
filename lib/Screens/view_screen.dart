import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Screens/searchPage.dart';
import 'homepage.dart';
import 'detail_screen.dart';

class view extends StatefulWidget {
  String s;
  view(this.s, {Key? key}) : super(key: key);

  @override
  viewState createState() => viewState(this.s);
}

class viewState extends State<view> {
  viewState(this.shoptype) {}
  late String shoptype;
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
      //print("Unable to retrieve");
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
                  MaterialPageRoute(builder: (c) => const main_page()));
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SearchPage()));
              },
              icon: const Icon(Icons.search_outlined)),
        ],
        backgroundColor: const Color.fromARGB(255, 2, 145, 170),
      ),
      body: loading == true
          ? Center(
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
                        height: 70,
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
                                    "Rating: ${shopslist[index]["Shop Rating"]}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
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
