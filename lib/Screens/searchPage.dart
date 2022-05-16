import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'detail_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool record = false;
  TextEditingController _searchController = TextEditingController();
  List searchshopslist = [];

  void initstate() {
    super.dispose();
    //fetchtopshoplist();
  }

  shoplist() async {
    searchshopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: _searchController.text.trim())
        .where("Shop status", isEqualTo: true)
        //.where("Shop Rating", isGreaterThanOrEqualTo: 4)
        //.orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        searchshopslist.add(result);
        if (searchshopslist.isEmpty) {
          if (mounted) {
            setState(() {
              record = true;
              searchshopslist = [];
            });
          }
        } else if (searchshopslist.isNotEmpty) {
          if (mounted) {
            setState(() {
              record = false;
            });
          }
        }
      });
    });
  }

  topshoplist() async {
    searchshopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: _searchController.text.trim())
        .where("Shop status", isEqualTo: true)
        .where("Shop Rating", isEqualTo: 5)
        //.orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        searchshopslist.add(result);
        if (searchshopslist.isEmpty) {
          if (mounted) {
            setState(() {
              record = true;
              searchshopslist = [];
            });
          }
        } else if (searchshopslist.isNotEmpty) {
          if (mounted) {
            setState(() {
              record = false;
            });
          }
        }
      });
    });
  }

  affordshoplist() async {
    searchshopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: _searchController.text.trim())
        .where("Shop status", isEqualTo: true)
        .where("Shop Affordability", isEqualTo: 9)
        //.where("Shop Rating", isGreaterThanOrEqualTo: 4)
        //.orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        searchshopslist.add(result);
        if (searchshopslist.isEmpty) {
          if (mounted) {
            setState(() {
              record = true;
              searchshopslist = [];
            });
          }
        } else if (searchshopslist.isNotEmpty) {
          if (mounted) {
            setState(() {
              record = false;
            });
          }
        }
      });
    });
  }

  late double _width;
  late String _btnText;

  @override
  void initState() {
    _width = 100;
    _btnText = "Search";
    super.initState();
  }

  Future _pretendSearch() async {
    setState(() {
      this._btnText = "";
      this._width = 36;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      this._btnText = "Search";
      this._width = 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(16),
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _searchBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      topshoplist();
                    },
                    icon: Icon(Icons.filter_1)),
                IconButton(
                    onPressed: () {
                      affordshoplist();
                    },
                    icon: Icon(Icons.filter_2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Top Rated"),
                Text("Affordable"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            record == true
                ? const Center(child: const Text("no record found"))
                : ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: searchshopslist.length,
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
                                      "${searchshopslist[index]["Shop Name"]}",
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
                                      "Service: ${searchshopslist[index]["Service"]}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Affordability: ${searchshopslist[index]["Shop Affordability"]}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey,
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
                                  //print(affordableshopslist[index].id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => detail_screen(
                                            searchshopslist[index].id,
                                            searchshopslist[index].data()),
                                      ));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ]),
    ));
  }

  Widget _searchBox() {
    return Container(
        width: kIsWeb ? 450 : double.infinity,
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          color: Color.fromARGB(255, 2, 145, 170),
          // gradient: const LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Color.fromARGB(255, 255, 255, 255),
          //       Color.fromARGB(255, 2, 145, 170),
          //     ]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            _searchField(),
            _searchBtn(),
          ],
        ));
  }

  Widget _searchField() {
    return Expanded(
        child: TextFormField(
      controller: _searchController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        hintText: "Type Name of Service",
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
          borderSide: BorderSide.none,
        ),
        prefixIcon: TextButton(
          child: Icon(
            Icons.cancel,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () {
            _searchController.clear();
            setState(() {
              searchshopslist = [];
            });
          },
        ),
      ),
      enabled: true,
      onChanged: (text) {},
    ));
  }

  Widget _searchBtn() {
    return AnimatedContainer(
        width: this._width,
        height: 36,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: this._btnText == "" ? _loadingBox() : _btnTextWidget(),
          onPressed: () async {
            shoplist();
            setState(() {});
            await _pretendSearch();
          },
        ));
  }

  Widget _btnTextWidget() {
    return Text(
      this._btnText,
      style: const TextStyle(
        color: Color.fromARGB(255, 2, 145, 170),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _loadingBox() {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(0),
        child: SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 247, 121, 3),
              valueColor: new AlwaysStoppedAnimation<Color>(
                const Color.fromARGB(255, 2, 145, 170),
              ),
            )));
  }
}
