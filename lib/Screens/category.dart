import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Screens/searchPage.dart';

import 'bike.dart';
import 'detail.dart';

class category extends StatefulWidget {
  String s;
  category(this.s, {Key? key}) : super(key: key);

  @override
  State<category> createState() => categoryState(this.s);
}

class categoryState extends State<category> {
  categoryState(this.type) {}
  late String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select_Category'),
        backgroundColor: const Color.fromARGB(255, 2, 145, 170),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => bike(type)));
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
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "Electrical"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/electric.png",
                    width: 60,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Electrical",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail(type, "Electrical"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "Mechanical"),
                    ));
              },
              child: Row(
                children: [
                  //SizedBox(width: 5,),
                  Image.asset(
                    "images/mechanical.png",
                    width: 80,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Mechanical",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail(type, "Mechanical"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "Tire Shop"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/tyres.png",
                    width: 70,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Tyres",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail(type, "Tire Shop"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          detail(type, "Denting and Painting"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/painting.png",
                    width: 70,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Denting and Painting",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                detail(type, "Denting and Painting"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "Spare Parts"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/spare.png",
                    width: 70,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Spare Parts",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail(type, "Spare Parts"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "Oil Change"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/b_oil.png",
                    width: 70,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Oil Change",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail(type, "Oil Change"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "Tire Shop"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/bike_wheel.png",
                    width: 70,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Wheel Alignment",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 145, 170)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail(type, "Tire Shop"),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
