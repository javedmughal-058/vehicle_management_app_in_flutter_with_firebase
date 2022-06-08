import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class block_shops extends StatefulWidget {
  const block_shops({Key? key}) : super(key: key);

  @override
  State<block_shops> createState() => _block_shopsState();
}

@override
class _block_shopsState extends State<block_shops> {
  @override
  bool loading = true;
  List blockedlist = [];
  List<String> blockshopkeys = [];

  @override
  void initState() {
    super.initState();
    blockedshoplist();
  }

  blockedshoplist() async {
    List lisofitem = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        //.orderBy("Shop Rating",descending: true)
        .where("Shop status", isEqualTo: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        lisofitem.add(result.data());
        blockshopkeys.add((result.id));
      });
    });
    loading = false;
    if (lisofitem.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "No record found",
      );
      print("Unable to retrieve");
    } else {
      setState(() {
        blockedlist = lisofitem;
        if (blockedlist.length > 9) {
          count = true;
        } else {
          count = false;
        }
      });
    }
  }

  void _unblockshop(String shopkey) {
    FirebaseFirestore.instance
        .collection("shops")
        .doc(shopkey)
        .update({"Shop status": true}).then((_) {
      print("success to unblock!");
    }).catchError((error) => print('Failed to unblock: $error'));
  }

  bool count = true;
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Row(
          children: [
            const Text("Blocked Shops"),
            const Spacer(),
            loading == true
                ? Center(
                    child: Container(
                      height: 14,
                      width: 14,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Color.fromARGB(255, 247, 121, 3),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  )
                : count == true
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text(
                          "9+",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo,
                          ),
                        ))
                    : Container(
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          "${blockedlist.length}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Container(
              // width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: loading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Color.fromARGB(255, 247, 121, 3),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      )
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: blockedlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                color: Colors.indigo,
                                child: Text(
                                  "${blockedlist[index]['type']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Shrikhand',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${blockedlist[index]['Owner Name']}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Shrikhand',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      "Shop: ${blockedlist[index]['Shop Name']}",
                                      maxLines: 2,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Shrikhand',
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Affordability: ${blockedlist[index]['Shop Affordability']}",
                                        style: const TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 12,
                                          fontFamily: 'Shrikhand',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Rating: ${blockedlist[index]['Shop Rating']}",
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontSize: 12,
                                          fontFamily: 'Shrikhand',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              TextButton.icon(
                                  label: const Text('Unblock'),
                                  icon: const Icon(Icons.block_rounded),
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                      _unblockshop(blockshopkeys[index]);
                                      loading == false
                                          ? Center(
                                              child: Container(
                                                //width: 120,height: 120,
                                                child:
                                                    const CircularProgressIndicator(
                                                  // backgroundColor: Colors.grey,
                                                  strokeWidth: 7,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.blue),
                                                ),
                                              ),
                                            )
                                          : blockedshoplist();
                                    });
                                  }),
                              const SizedBox(
                                width: 5,
                              ),
                            ]),
                          );
                        },
                      ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
