import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Screens/easy_search_bar.dart';
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

  Future<void> _refresh() async {
    setState(() {});
    await fetchdatalist();
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => easysearchbar()));
              },
              icon: const Icon(Icons.search_outlined)),
        ],
        backgroundColor: const Color.fromARGB(255, 2, 145, 170),
      ),
      body: loading == true
          ? const Center(
              child: SpinKitFadingCircle(
                color: Color.fromARGB(255, 2, 145, 170),
                size: 50.0,
              ),
            )
          : RefreshIndicator(
              onRefresh: _refresh,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: Colors.white,
              backgroundColor: Color.fromARGB(255, 2, 145, 170),
              //displacement: 100,
              strokeWidth: 2,
              edgeOffset: 20,
              child: ListView(
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
                    height: 5,
                  ),
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: shopslist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
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
                                      itemCount: shopslist[index]
                                          ['Shop Rating'],
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
            ),
    );
  }
}
