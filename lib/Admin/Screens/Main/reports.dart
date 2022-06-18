import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/admin_profile.dart';

import 'admin_profile.dart';

class reports extends StatefulWidget {
  const reports({Key? key}) : super(key: key);

  @override
  State<reports> createState() => _reportsState();
}

class _reportsState extends State<reports> {
  bool loading = true;
  List complaintlist = [];
  List complaintedshoplist = [];
  List<String> shopkeys = [];

  @override
  void initState() {
    super.initState();
    complaintshoplist();
    //complaintedshop(shopkeys);
  }

  complaintshoplist() async {
    List lisofcomplaint = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("complaints")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        lisofcomplaint.add(result.data());
        shopkeys.add(result.id);
      });
    });
    loading = false;
    if (lisofcomplaint.isEmpty) {
      CoolAlert.show(
          context: context, type: CoolAlertType.info, text: "No record found");
    } else {
      setState(() {
        complaintlist = lisofcomplaint;

        if (complaintlist.length > 9) {
          count = true;
        } else {
          count = false;
        }
      });
    }
  }

  void _reject(String shopkey) {
    FirebaseFirestore.instance
        .collection("complaints")
        .doc(shopkey)
        .delete()
        .then((_) {
      //print("success!");
    }).catchError((error) => print('Delete failed: $error'));
  }

  void _accept(String shopkey) {
    FirebaseFirestore.instance
        .collection("shops")
        .doc(shopkey)
        .update({"Shop status": false}).then((_) {
      print("success to accept!");
    }).catchError((error) => print('Acception failed: $error'));
  }

  // void complaintedshop(String shopkey) async {
  //   List complaintedshoplist = [];
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(shopkey)
  //       .get()
  //       .then((value) => print(value.data()));
  // }

  bool count = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.indigo,
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Row(
            children: [
              const Text("Complaints"),
              const Spacer(),
              loading == true
                  ? Center(
                      child: Container(
                        height: 14,
                        width: 14,
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Color.fromARGB(255, 247, 121, 3),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    )
                  : count == false
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "${complaintlist.length}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.indigo,
                            ),
                          ),
                        )
                      : Container(
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
                          )),
            ],
          )),
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
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: complaintlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 220,
                            width: 300,
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
                              SizedBox(
                                width: 270,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        complaintshoplist();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Stack(
                                                  overflow: Overflow.visible,
                                                  children: <Widget>[
                                                    Positioned(
                                                      right: -40.0,
                                                      top: -40.0,
                                                      child: InkResponse(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const CircleAvatar(
                                                          child:
                                                              Icon(Icons.close),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        const Text(
                                                          "Complainted shop details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const Text(
                                                          "------------------------------",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              width: 250,
                                                              child: Text(
                                                                "Owner Name: ${complaintlist[index]['Owner Name']}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                softWrap: false,
                                                              ),
                                                            )),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                "Shop Type: ${complaintlist[index]['Shop Type']}")),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                "Service: ${complaintlist[index]['Shop Service']}")),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                "Affordability: ${complaintlist[index]['Shop Affordability']}")),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              RatingBar.builder(
                                                            //glowColor: Colors.amber,
                                                            unratedColor:
                                                                Colors.amber,
                                                            direction:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                complaintlist[
                                                                        index][
                                                                    'Shop Rating'],
                                                            itemSize: 18.0,
                                                            itemPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        1.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {},
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            FlutterPhoneDirectCaller
                                                                .callNumber(
                                                                    '0${complaintlist[index]['Owner Contact']}');
                                                          },
                                                          icon: const Icon(Icons
                                                              .call_rounded),
                                                          color: Colors.green,
                                                          iconSize: 35,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        "To: ${complaintlist[index]['Shop Name']}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Shrikhand',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Detail: ${complaintlist[index]['complaint']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Shrikhand',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "By: ${complaintlist[index]['reporter_name']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Shrikhand',
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton.icon(
                                            label: const Text('Accept'),
                                            icon: const Icon(
                                              Icons.one_k,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                loading = true;
                                                _accept(shopkeys[index]);
                                                _reject(shopkeys[index]);

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
                                                                        Color>(
                                                                    Colors
                                                                        .blue),
                                                          ),
                                                        ),
                                                      )
                                                    : complaintshoplist();
                                              });
                                            }),
                                        TextButton.icon(
                                            label: const Text('Reject'),
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                loading = true;
                                                _reject(shopkeys[index]);
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
                                                                        Color>(
                                                                    Colors
                                                                        .blue),
                                                          ),
                                                        ),
                                                      )
                                                    : complaintshoplist();
                                              });
                                            }),
                                        IconButton(
                                          onPressed: () {
                                            FlutterPhoneDirectCaller.callNumber(
                                                '0${complaintlist[index]['reporter_contact']}');
                                          },
                                          icon: const Icon(Icons.call_rounded),
                                          color: Colors.green,
                                          iconSize: 35,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
