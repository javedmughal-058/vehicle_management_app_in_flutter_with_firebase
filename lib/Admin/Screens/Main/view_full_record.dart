import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/view_record.dart';
import 'package:vehicle_maintainance/Screens/detail.dart';

import 'add_car_record.dart';

class view_full_record extends StatefulWidget {
  String str;
  view_full_record(this.str, {Key? key}) : super(key: key);

  @override
  State<view_full_record> createState() => _view_full_recordState(this.str);
}

class _view_full_recordState extends State<view_full_record> {
  _view_full_recordState(this.record_name) {}
  bool loading = true;
  late String record_name;
  List shopslist = [];
  List<String> shopkeys = [];
  @override
  void initState() {
    super.initState();
    fetchdatalist();
  }

  fetchdatalist() async {
    shopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        //.orderBy("Shop Rating",descending: true)
        .where("type", isEqualTo: record_name)
        .limit(1000)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        shopslist.add(result.data());
        shopkeys.add(result.id);
      });
    });
    loading = false;
    if (shopslist.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "No record found",
      );
      print("Unable to retrieve");
    } else {
      setState(() {
        if (shopslist.length > 9) {
          count = true;
        } else {
          count = false;
        }
      });
    }
  }

  void _delete(String shopkey) {
    FirebaseFirestore.instance
        .collection("shops")
        .doc(shopkey)
        .delete()
        .then((_) {
      //print("success!");
    }).catchError((error) => print('Delete failed: $error'));
  }

  //  Future deleteData(String id) async{
  //    try {
  //      await  FirebaseFirestore.instance
  //          .collection("shops")
  //          .doc(FirebaseAuth.instance.currentUser!.uid)
  //          .collection("collection_name")
  //          .doc(id)
  //          .delete();
  //    }catch (e){
  //      return false;
  //    }
  // }
  bool count = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const view_record()));
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Row(
          children: [
            Text("$record_name records"),
            const Spacer(),
            loading == true
                ? Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      child: const CircularProgressIndicator(
                        // backgroundColor: Colors.grey,
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                          "${shopslist.length}",
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
                    ? Center(
                        child: Container(
                          //width: 120,height: 120,
                          child: const CircularProgressIndicator(
                            // backgroundColor: Colors.grey,
                            strokeWidth: 7,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: shopslist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(3, 5, 3, 2),
                            height: 85,
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
                              Text(
                                "${shopslist[index]['Shop Rating']}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontFamily: 'Shrikhand',
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${shopslist[index]['Owner Name']}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Shrikhand',
                                    ),
                                  ),
                                  Text(
                                    "Service: ${shopslist[index]['Service']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Shrikhand',
                                    ),
                                  ),
                                  Text(
                                    "Rs/km: ${shopslist[index]['Rs/km']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Shrikhand',
                                    ),
                                  ),
                                  shopslist[index]['Shop status'] == true
                                      ? const Text(
                                          "Status: unblocked",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Shrikhand',
                                          ),
                                        )
                                      : const Text(
                                          "Status: blocked",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Shrikhand',
                                          ),
                                        )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                color: Colors.indigo,
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> detail(type,"Electrical"),));
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20,
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  //print(shopslist[index]);

                                  setState(() {
                                    loading = true;
                                    _delete(shopkeys[index]);
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
                                        : fetchdatalist();
                                  });

                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> detail(type,"Electrical"),));
                                },
                              ),
                            ]),
                          );
                        },
                      ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => add_car_record()));
            },
            tooltip: 'Add Record',
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              size: 25,
              color: Colors.indigo,
            ),
          ),
        ]),
      ),
    );
  }
}
