import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vehicle_maintainance/Screens/detail_screen.dart';
import 'package:vehicle_maintainance/Screens/view_screen.dart';
import 'bike.dart';
import 'car.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late String record_name;
  List shopslist = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    fetchdatalist();
  }

  fetchdatalist() async {
    List lisofitem = [];
    await FirebaseFirestore.instance
        .collection("shops")
        .where("Shop status", isEqualTo: true)
        .where("Shop Rating", whereIn: [4, 5])
        //  .orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            // print(result.data());
            lisofitem.add(result);
            if (lisofitem.isNotEmpty) {
              if (mounted) {
                setState(() {
                  shopslist = lisofitem;
                  record = false;
                  first = false;
                  loading = false;
                });
              }
            } else {
              record = true;
            }
          });
        });
  }

  final List _imagesource = ['images/a.png', 'images/b.png', 'images/c.png'];
  bool first = true;
  bool loading = true;
  bool record = true;
  Future<void> _refresh() async {
    setState(() {});
    await fetchdatalist();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      fetchdatalist();
    }
    return RefreshIndicator(
      onRefresh: _refresh,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      color: Colors.white,
      backgroundColor: Color.fromARGB(255, 2, 145, 170),
      //displacement: 100,
      strokeWidth: 2,
      edgeOffset: 20,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 200,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            // color: Colors.amber[600],
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: _imagesource.map(
                (imagepath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(100),
                                child: Image.asset(imagepath))),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _imagesource.map((urlOfItem) {
              int index = _imagesource.indexOf(urlOfItem);
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Color.fromARGB(255, 2, 145, 170)
                      : Color.fromRGBO(0, 0, 0, 0.3),
                ),
              );
            }).toList(),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(width: 10,),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => bike("bike"),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      height: 170,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 2, 145, 170),
                      ),
                      child: Column(
                        children: [
                          Image.asset("images/bike.png"),
                          const Text(
                            'Bike',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          //SizedBox(height: 7,),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => car("car"),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      // color: Colors.red,
                      height: 170,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 2, 145, 170),
                      ),
                      child: Column(
                        children: [
                          Image.asset("images/car.png"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Car',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            //color:Color(0xFF37474F),
            height: 40,
            //color: Colors.amber[100],
            child: Text(
              "Recommended",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  color: const Color(0xFF37474F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 130,
            //width: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => view("wash")));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.red,
                    height: 110,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "images/wash.png",
                          height: 70,
                          width: 70,
                        ),
                        const Text(
                          'Wash',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => view("battery")));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.red,
                    height: 110,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Image.asset("images/battery.png",
                            height: 55, width: 70),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Battery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => view("air conditioner")));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.red,
                    height: 110,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Image.asset("images/ac.png", height: 60, width: 60),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Air Conditioner',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            //color:Color(0xFF37474F),
            height: 40,
            //color: Colors.amber[100],
            child: Text(
              "Top Rated Shops",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  color: const Color(0xFF37474F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 280,
              child: record == true
                  ? const Center(
                      child: Text("No reocrd found"),
                    )
                  : loading == true
                      ? Center(
                          child: Container(
                            //width: 120,height: 120,
                            child: const SpinKitFadingFour(
                              color: Color.fromARGB(255, 2, 145, 170),
                              size: 50.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: shopslist.length,
                          itemBuilder: (context, index) => Card(
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => detail_screen(
                                            shopslist[index].id,
                                            shopslist[index].data()),
                                      ));
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  // color: Colors.red,
                                  height: 250,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
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
                                      Container(
                                          child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.asset(
                                          "images/cs1.jpg",
                                        ),
                                      )),
                                      //Divider(height: 10,color: Colors.black,),
                                      Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: SizedBox(
                                          width: 200.0,
                                          child: Column(
                                            children: [
                                              Text(
                                                  '${shopslist[index]['Shop Name']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      GoogleFonts.merriweather(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                'Shop Type: ${shopslist[index]['type']}',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              RatingBar.builder(
                                                allowHalfRating: true,
                                                //glowColor: Colors.amber,
                                                unratedColor: Colors.amber,
                                                direction: Axis.horizontal,
                                                itemCount: shopslist[index]
                                                    ['Shop Rating'],
                                                itemSize: 18.0,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  //print(rating);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
