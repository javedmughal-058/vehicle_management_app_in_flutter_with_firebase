import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category.dart';
import 'detail_screen.dart';
import 'homepage.dart';

class bike extends StatefulWidget {
  String str;
  bike(this.str, {Key? key}) : super(key: key);
  @override
  _bikeState createState() => _bikeState(this.str);
}

class _bikeState extends State<bike> {
  _bikeState(this.type) {}
  bool loading = true;
  late String type;
  List topshopslist = [];
  List affordableshopslist = [];
  // List affordableshopkeys=[];
  @override
  void initState() {
    super.initState();
    fetchtopshoplist();
    fetchaffordableshoplist();
  }

  fetchtopshoplist() async {
    List lisoftopitem = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: type)
        .where("Shop status", isEqualTo: true)
        .where("Shop Rating", whereIn: [5])
        //.orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            //print(result.data());
            lisoftopitem.add(result);
            if (mounted) {
              setState(() {
                topshopslist = lisoftopitem;
                loading = false;
              });
            }
          });
        });
  }

  fetchaffordableshoplist() async {
    List lisofaffordableitem = [];
    await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: type)
        .where("Shop status", isEqualTo: true)
        .where("Shop Affordability", whereIn: [9, 10])
        //.where("Shop Affordability",isEqualTo: 10)
        .get()
        .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            //print(result.data());
            lisofaffordableitem.add(result);
            setState(() {
              affordableshopslist = lisofaffordableitem;
              loading = false;
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = const SpinKitFadingCircle(
      color: Color.fromARGB(255, 2, 145, 170),
      size: 50.0,
    );
    if (loading) {
      loadingWidget;
    } else {
      loadingWidget = const Center(); //EmptyWidget
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(type),
        backgroundColor: const Color.fromARGB(255, 2, 145, 170),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const main_page()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: const Text(
              "Catagories",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width: 3,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category(type),
                          ));
                    },
                    child: Container(
                      //color: Colors.black26,
                      padding: const EdgeInsets.fromLTRB(3, 5, 2, 5),
                      // color: Colors.red,
                      height: 125,
                      width: 105,
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
                          Image.asset("images/honda_bike.png"),
                          const Text(
                            'HONDA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(width: 3,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category(type),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                      // color: Colors.red,
                      height: 125,
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 2, 145, 170),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/yamaha.png",
                            height: 65,
                            width: 65,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'YAHAMA',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 3,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category(type),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // color: Colors.red,
                      height: 125,
                      width: 105,
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
                          Image.asset(
                            "images/crown.png",
                            height: 80,
                            width: 80,
                          ),
                          const Text(
                            'CROWN',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(width: 3,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category(type),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // color: Colors.red,
                      height: 125,
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 2, 145, 170),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            "images/superpower.png",
                            height: 75,
                            width: 75,
                          ),
                          // SizedBox(height: 10,),
                          const Text(
                            'Super Power',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 3,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category(type),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // color: Colors.red,
                      height: 125,
                      width: 105,
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
                          Image.asset(
                            "images/united.png",
                            height: 80,
                            width: 80,
                          ),
                          const Text(
                            'UNITED',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(width: 3,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category(type),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // color: Colors.red,
                      height: 125,
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 2, 145, 170),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/ravi.png",
                            height: 80,
                            width: 80,
                          ),
                          //SizedBox(height: 10,),
                          const Text(
                            'RAVI',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: Color.fromARGB(255, 2, 145, 170),
            height: 40,
            //color: Colors.amber[100],
            child: Text(
              "Top Rated Shops",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 270,
            child: loading
                ? loadingWidget
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: topshopslist.length,
                    itemBuilder: (context, index) => Card(
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => detail_screen(
                                      topshopslist[index].id,
                                      topshopslist[index].data()),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                    topLeft: const Radius.circular(10),
                                    topRight: const Radius.circular(10),
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
                                            '${topshopslist[index]['Shop Name']}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.merriweather(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Shop Type: ${topshopslist[index]['type']}',
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
                                          //glowColor: Colors.amber,
                                          unratedColor: Colors.amber,
                                          direction: Axis.horizontal,
                                          itemCount: topshopslist[index]
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
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: const Text(
              "Suggested Shops",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          loading
              ? loadingWidget
              : ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: affordableshopslist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 90,
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
                            const Icon(Icons.home_work_sharp),
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
                                    "${affordableshopslist[index]["Shop Name"]}",
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
                                    "Service: ${affordableshopslist[index]["Service"]}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Affordability: ${affordableshopslist[index]["Shop Affordability"]}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RatingBar.builder(
                                    //glowColor: Colors.amber,
                                    unratedColor: Colors.amber,
                                    direction: Axis.horizontal,
                                    itemCount: affordableshopslist[index]
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
                                //print(affordableshopslist[index].id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detail_screen(
                                          affordableshopslist[index].id,
                                          affordableshopslist[index].data()),
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
