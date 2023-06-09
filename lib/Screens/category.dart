
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Screens/searchPage.dart';

import 'bike.dart';
import 'detail.dart';
import 'easy_search_bar.dart';

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => easysearchbar()));
              },
              icon: const Icon(Icons.search_outlined)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "electrical"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/electric.png",
                    width: 50,
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
                            builder: (context) => detail(type, "electrical"),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "mechanical"),
                    ));
              },
              child: Row(
                children: [
                  //SizedBox(width: 5,),
                  Image.asset(
                    "images/mechanical.png",
                    width: 70,
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
                            builder: (context) => detail(type, "mechanical"),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "tire"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/tyres.png",
                    width: 60,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Tire Shops",
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
                            builder: (context) => detail(type, "tire"),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          detail(type, "denting and painting"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/painting.png",
                    width: 50,
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
                                detail(type, "denting and painting"),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "spare parts"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/spare.png",
                    width: 60,
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
                            builder: (context) => detail(type, "spare parts"),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "oil change"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/b_oil.png",
                    width: 60,
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
                            builder: (context) => detail(type, "oil change"),
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail(type, "tire"),
                    ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/bike_wheel.png",
                    width: 60,
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
                            builder: (context) => detail(type, "tire"),
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
