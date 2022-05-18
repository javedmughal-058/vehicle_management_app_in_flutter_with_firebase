import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'detail_screen.dart';

class easysearchbar extends StatefulWidget {
  const easysearchbar({Key? key}) : super(key: key);

  @override
  State<easysearchbar> createState() => _easysearchbarState();
}

class _easysearchbarState extends State<easysearchbar> {
  bool record = false;
  bool _pressed = false;
  TextEditingController _searchController = TextEditingController();
  List searchshopslist = [];

  void initstate() {
    super.dispose();
    //fetchtopshoplist();
  }

  shoplist() async {
    String searchtxt = _searchController.text.trim();
    setState(() {
      searchtxt = searchtxt.toLowerCase();
    });
    searchshopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: searchValue)
        .where("Shop status", isEqualTo: true)
        //.where("Shop Rating", isGreaterThanOrEqualTo: 4)
        //.orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        searchshopslist.add(result);
        if (searchshopslist.isEmpty) {
          record = true;
          if (mounted) {
            setState(() {
              searchshopslist = [];
            });
          }
        } else if (searchshopslist.isNotEmpty) {
          if (mounted) {
            record = false;

            setState(() {});
          }
        }
      });
    });
  }

  topshoplist() async {
    String searchtxt = _searchController.text.trim();
    setState(() {
      searchtxt = searchtxt.toLowerCase();
    });
    searchshopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: searchValue)
        .where("Shop status", isEqualTo: true)
        .where("Shop Rating", whereIn: [4, 5])
        //.orderBy("Shop Rating", descending: true)
        .get()
        .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            //print(result.data());
            searchshopslist.add(result);
            if (searchshopslist.isEmpty) {
              if (mounted) {
                setState(() {
                  searchshopslist = [];
                });
              }
            } else if (searchshopslist.isNotEmpty) {
              if (mounted) {
                setState(() {});
              }
            }
          });
        });
  }

  affordshoplist() async {
    String searchtxt = _searchController.text.trim();
    setState(() {
      searchtxt = searchtxt.toLowerCase();
    });
    searchshopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: searchValue)
        .where("Shop status", isEqualTo: true)
        .where("Shop Affordability", whereIn: [8, 9, 10])
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
                  searchshopslist = [];
                });
              }
            } else if (searchshopslist.isNotEmpty) {
              if (mounted) {
                setState(() {});
              }
            }
          });
        });
  }

  String searchValue = '';
  final List<String> _suggestions = [
    'electrical',
    'mechanical',
    'oil change',
    'tire',
    'spare parts',
    'denting and painting',
    'wheel alignment',
    'air conditioner'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EasySearchBar(
            backgroundColor: Colors.white,
            title: Text(""),
            onSearch: (value) => setState(() {
                  searchValue = value;
                  shoplist();
                  _pressed = true;
                  setState(() {});
                }),
            asyncSuggestions: (value) async => await _fetchSuggestions(value)),
        body: ListView(
          children: [
            _pressed
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          _pressed = true;
                          topshoplist();
                          setState(() {});
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.align_vertical_center_rounded,
                              color: Color.fromARGB(221, 4, 70, 78),
                            ),
                            Text("Top Rated"),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _pressed = true;
                          affordshoplist();
                          setState(() {});
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.align_vertical_center_outlined,
                              color: Color.fromARGB(221, 4, 70, 78),
                            ),
                            Text("Affordable"),
                          ],
                        ),
                      ),
                    ],
                  )
                : Text(""),
            const SizedBox(
              height: 5,
            ),
            record
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
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,

                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 3,
                            //     blurRadius: 5,
                            //     offset: const Offset(
                            //         0, 3), // changes position of shadow
                            //   ),
                            // ]
                          ),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Shop: ${searchshopslist[index]["type"]}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: const Color.fromARGB(
                                                  255, 2, 145, 170),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Service: ${searchshopslist[index]["Service"]}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: const Color.fromARGB(
                                                  255, 2, 145, 170),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
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
                                    RatingBar.builder(
                                      //glowColor: Colors.amber,
                                      unratedColor: Colors.amber,
                                      direction: Axis.horizontal,
                                      itemCount: searchshopslist[index]
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
                                  Icons.arrow_forward_ios_outlined,
                                  size: 25,
                                ),
                                color: const Color.fromARGB(255, 2, 145, 170),
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
          ],
        ));
  }
}
