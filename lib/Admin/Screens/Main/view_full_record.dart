import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/view_record.dart';
import 'package:vehicle_maintainance/Screens/detail.dart';
import 'package:vehicle_maintainance/Screens/map.dart';

import 'add_car_record.dart';

class view_full_record extends StatefulWidget {
  String str;
  view_full_record(this.str, {Key? key}) : super(key: key);

  @override
  State<view_full_record> createState() => _view_full_recordState(this.str);
}

class _view_full_recordState extends State<view_full_record> {
  _view_full_recordState(this.record_name) {}

  String dropdownValue = '';
  String shopservice = "mechanical", OServices = "Yes";
  final listOfServices = [
    "mechanical",
    "oil change",
    "electrical",
    "denting and painting",
    "tire",
    "spare parts",
    "air conditioner"
  ];
  final listOfServices2 = [
    "mechanical",
    "oil change",
    "electrical",
    "denting and painting",
    "tire",
    "spare parts",
  ];
  getdropdownValue5(newValueSelected) {
    this.record_name = newValueSelected;
  }

  String dropdownValue3 = 'Yes';
  final OutdoorServices = ["Yes", "No"];
  getdropdownValue3(Outservice) {}

  bool loading = true;
  bool status = true;
  late String record_name;
  late String shopstatus;
  final shop_status = ["true", "false"];
  String dropdownValue2 = 'true';
  getdropdownValue(service) {
    this.shopservice = service;
  }

  List shopslist = [];
  List<String> shopkeys = [];
  @override
  void initState() {
    super.initState();
    fetchdatalist();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  fetchdatalist() async {
    shopslist = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("type", isEqualTo: record_name)
        .orderBy("Shop Rating", descending: true)
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

  List singleshop = [];
  Future<void> singlerecord(String shopkey) async {
    singleshop = [];
    await FirebaseFirestore.instance
        .collection("shops")
        .doc(shopkey)
        .get()
        .then((value) {
      //print(value.data());
      singleshop.add(value.data());
    }).catchError((error) => print('Retrieve failed: $error'));
  }

  Map record = {};
  Future<void> _update(String shopkey) async {
    Map<String, dynamic> temp = Map.from(record);
    try {
      await FirebaseFirestore.instance
          .collection("shops")
          .doc(shopkey)
          .update(Map.from(record))
          .whenComplete(() {
        print("successfully update!");
      });
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pop();

    const AdvanceSnackBar(
            message: "Successfully updated record",
            duration: Duration(seconds: 5),
            child: Padding(
              padding: EdgeInsets.only(left: 2),
              child: Icon(
                Icons.all_inbox,
                color: Colors.red,
                size: 25,
              ),
            ),
            isIcon: true)
        .show(context);
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
  bool value = true;
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
                      height: 14,
                      width: 14,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
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
                        child: Text(
                          "${shopslist.length}",
                          style: const TextStyle(
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
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor:
                              const Color.fromARGB(255, 247, 121, 3),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      )
                    : ListView(
                        children: [
                          if (record_name == 'bike' || record_name == 'car')
                            SizedBox(
                              height: 50,
                              //width: 200,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      // color: Colors.red,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          'Electrical',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      // color: Colors.red,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          'Mechanical',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      // color: Colors.red,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          'Oil Change',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      // color: Colors.red,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          'Denting and Painting',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      // color: Colors.red,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          'Tire',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      // color: Colors.red,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          'Spare Parts',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (record_name == 'car')
                                    TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        // color: Colors.red,
                                        height: 80,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white),
                                        child: const Center(
                                          child: Text(
                                            'Air Conditiner',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: shopslist.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.fromLTRB(13, 5, 13, 13),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      SizedBox(
                                        width: 175,
                                        child: Text(
                                          "${shopslist[index]['Shop Name']}",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Shrikhand',
                                          ),
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
                                      shopslist[index]["Shop status"] == status
                                          ? const Text(
                                              "Shop status: Unblocked",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Shrikhand',
                                              ),
                                            )
                                          : const Text(
                                              "Shop status: blocked",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Shrikhand',
                                              ),
                                            ),
                                      // shopslist[index]['Shop status'] == status
                                      //     ? const Text(
                                      //         "Status: unblocked",
                                      //         style: TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: 12,
                                      //           fontFamily: 'Shrikhand',
                                      //         ),
                                      //       )
                                      //     : const Text(
                                      //         "Status: blocked",
                                      //         style: TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: 12,
                                      //           fontFamily: 'Shrikhand',
                                      //         ),
                                      //       )
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                    color: Colors.indigo,
                                    onPressed: () async {
                                      await singlerecord(shopkeys[index]);
                                      record = singleshop[0];

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
                                                      child: const CircleAvatar(
                                                        child:
                                                            Icon(Icons.close),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  Form(
                                                    key: _formKey,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    child: ListView(
                                                      // mainAxisSize:
                                                      //     MainAxisSize.min,
                                                      children: <Widget>[
                                                        TextFormField(
                                                            //controller: _shopname,
                                                            initialValue:
                                                                '${record["Shop Name"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Shop Name',
                                                              // icon: Icon(
                                                              //     Icons.person),
                                                            ),
                                                            onSaved: (val) {
                                                              record["Shop Name"] =
                                                                  val;
                                                              //print(val);
                                                            }

                                                            // onChanged: (String
                                                            //     repotername) {
                                                            //   getreporterName(
                                                            //       repotername);
                                                            // },
                                                            ),
                                                        TextFormField(
                                                            //controller: _ownername,
                                                            initialValue:
                                                                '${record["Owner Name"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Owner Name',
                                                              // icon:
                                                              //     Icon(Icons.phone),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Enter Name';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {
                                                              record["Owner Name"] =
                                                                  val;
                                                              //print(val);
                                                            }

                                                            // onChanged: (String
                                                            //     reportercontact) {
                                                            //   getreporterContact(
                                                            //       reportercontact);
                                                            // },
                                                            ),
                                                        TextFormField(

                                                            // controller: _contact,
                                                            initialValue:
                                                                '${record["Contact"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Owner Contact',
                                                              hintText:
                                                                  'Enter number without 0',
                                                              // icon: Icon(Icons
                                                              //     .message_outlined),
                                                            ),
                                                            validator: (value) {
                                                              String pattern =
                                                                  r'(^(?:[+0]9)?[0-9]{10}$)';
                                                              RegExp regExp =
                                                                  RegExp(
                                                                      pattern);
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Please enter mobile number';
                                                              } else if (!regExp
                                                                  .hasMatch(
                                                                      value)) {
                                                                return 'Please enter valid mobile number';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {
                                                              record["Contact"] =
                                                                  val;
                                                              //print(val);
                                                            }
                                                            // onChanged: (String
                                                            //     complaintdetail) {
                                                            //   getcomplaint(
                                                            //       complaintdetail);
                                                            // },
                                                            ),
                                                        TextFormField(
                                                            //controller: _location,
                                                            initialValue:
                                                                '${record["Location"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Location',
                                                              // icon: Icon(Icons
                                                              //     .message_outlined),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'location';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {
                                                              record["Location"] =
                                                                  val;
                                                              //print(val);
                                                            }

                                                            // onChanged: (String
                                                            //     complaintdetail) {
                                                            //   getcomplaint(
                                                            //       complaintdetail);
                                                            // },
                                                            ),
                                                        TextFormField(
                                                            readOnly: true,

                                                            //controller: _shoptype,
                                                            initialValue:
                                                                '${record["type"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Shop Type',
                                                              // icon: Icon(Icons
                                                              //     .message_outlined),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Enter type';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {
                                                              record["type"] =
                                                                  val;
                                                              //print(val);
                                                            }

                                                            // onChanged: (String
                                                            //     complaintdetail) {
                                                            //   getcomplaint(
                                                            //       complaintdetail);
                                                            // },
                                                            ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        if (record["type"] ==
                                                            'bike')
                                                          DropdownButtonFormField(
                                                            value:
                                                                '${record["Service"]}',
                                                            icon: const Icon(Icons
                                                                .keyboard_arrow_down_sharp),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Select Service Once at a time",
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                            ),
                                                            items:
                                                                listOfServices2
                                                                    .map((String
                                                                        value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                            onSaved: (val) {
                                                              record["Service"] =
                                                                  val;
                                                              //print(val);
                                                            },
                                                            onChanged: (String?
                                                                service) {
                                                              getdropdownValue(
                                                                  service);

                                                              // getService=(service);
                                                              setState(() {
                                                                dropdownValue =
                                                                    service!;
                                                              });
                                                            },
                                                          ),
                                                        if (record["type"] ==
                                                            'car')
                                                          DropdownButtonFormField(
                                                            value:
                                                                '${record["Service"]}',
                                                            icon: const Icon(Icons
                                                                .keyboard_arrow_down_sharp),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Select Service Once at a time",
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                            ),
                                                            items:
                                                                listOfServices
                                                                    .map((String
                                                                        value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                            onSaved: (val) {
                                                              record["Service"] =
                                                                  val;
                                                              //print(val);
                                                            },
                                                            onChanged: (String?
                                                                service) {
                                                              getdropdownValue(
                                                                  service);
                                                              // getService=(service);
                                                              setState(() {
                                                                dropdownValue =
                                                                    service!;
                                                              });
                                                            },
                                                          ),
                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(10.0),
                                                        //   child: DropdownButtonFormField(
                                                        //     value: '${record["Outdoor Services"]}',
                                                        //     icon: const Icon(Icons.keyboard_arrow_down_sharp),
                                                        //     decoration: InputDecoration(
                                                        //       labelText: "Outdoor Service",
                                                        //       enabledBorder: OutlineInputBorder(
                                                        //         borderRadius: BorderRadius.circular(10.0),
                                                        //       ),
                                                        //     ),
                                                        //     items: OutdoorServices.map((String value) {
                                                        //       return DropdownMenuItem<String>(
                                                        //         value: value,
                                                        //         child: Text(value),
                                                        //       );
                                                        //     }).toList(),
                                                        //     onChanged: (String? Outservice) {
                                                        //       getdropdownValue3(Outservice);
                                                        //       // getService=(service);
                                                        //       setState(() {
                                                        //         dropdownValue2 = Outservice!;
                                                        //       });
                                                        //     },
                                                        //   ),
                                                        // ),

                                                        TextFormField(
                                                            //controller: _outdoor,
                                                            initialValue:
                                                                '${record["Outdoor Services"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  'yes/no',
                                                              labelText:
                                                                  'Outdoor Service',
                                                              icon: Icon(Icons
                                                                  .message_outlined),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Mention yes/no';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {
                                                              record["Outdoor Services"] =
                                                                  val;
                                                              //print(val);
                                                            }

                                                            // onChanged: (String
                                                            //     complaintdetail) {
                                                            //   getcomplaint(
                                                            //       complaintdetail);
                                                            // },
                                                            ),
                                                        TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            //controller: _rate,
                                                            initialValue:
                                                                '${record["Rate"]}',
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Rs/km',
                                                              icon: Icon(Icons
                                                                  .message_outlined),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Rs/km';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {
                                                              record["Rate"] =
                                                                  val;
                                                              //print(val);
                                                            }

                                                            // onChanged: (String
                                                            //     complaintdetail) {
                                                            //   getcomplaint(
                                                            //       complaintdetail);
                                                            // },
                                                            ),
                                                        TextFormField(
                                                          readOnly: true,
                                                          //controller: _rating,
                                                          initialValue:
                                                              '${record["Shop Rating"]}',
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText: '(1-5)',
                                                            labelText:
                                                                'Shop Rating',
                                                            icon: Icon(Icons
                                                                .message_outlined),
                                                          ),

                                                          // onChanged: (String
                                                          //     complaintdetail) {
                                                          //   getcomplaint(
                                                          //       complaintdetail);
                                                          // },
                                                        ),
                                                        TextFormField(
                                                          readOnly: true,
                                                          //controller:_affordability,
                                                          initialValue:
                                                              '${record['Shop Affordability']}',
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText: '(1-10)',
                                                            labelText:
                                                                'Shop Affordability',
                                                            icon: Icon(Icons
                                                                .message_outlined),
                                                          ),

                                                          // onChanged: (String
                                                          //     complaintdetail) {
                                                          //   getcomplaint(
                                                          //       complaintdetail);
                                                          // },
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets.all(
                                                        //           10.0),
                                                        //   child:
                                                        //       DropdownButtonFormField(
                                                        //     icon: const Icon(Icons
                                                        //         .keyboard_arrow_down_sharp),
                                                        //     decoration:
                                                        //         InputDecoration(
                                                        //       labelText:
                                                        //           "Shop Status",
                                                        //       enabledBorder:
                                                        //           OutlineInputBorder(
                                                        //         borderRadius:
                                                        //             BorderRadius
                                                        //                 .circular(
                                                        //                     10.0),
                                                        //       ),
                                                        //     ),
                                                        //     items: shop_status.map(
                                                        //         (String value) {
                                                        //       return DropdownMenuItem<
                                                        //           String>(
                                                        //         value: value,
                                                        //         child: Text(value),
                                                        //       );
                                                        //     }).toList(),
                                                        //     onChanged: (String?
                                                        //         shopstatus) {
                                                        //       getdropdownValue2(
                                                        //           shopstatus);
                                                        //       // getService=(service);
                                                        //       setState(() {
                                                        //         record["Shop status"] =
                                                        //             shopstatus!;
                                                        //       });
                                                        //     },
                                                        //   ),
                                                        // ),
                                                        TextFormField(
                                                          readOnly: true,
                                                          // controller: _status,
                                                          initialValue:
                                                              '${record['Shop status']}',
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'true/false',
                                                            labelText:
                                                                'Shop Status',
                                                            icon: Icon(Icons
                                                                .message_outlined),
                                                          ),
                                                          // validator: (value) {
                                                          //   if (value!.isEmpty) {
                                                          //     return 'Enter status';
                                                          //   }
                                                          //   return null;
                                                          // },
                                                          // onSaved: (val) {
                                                          //   record["Shop status"] =
                                                          //       val;
                                                          //   //print(val);
                                                          // },
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            RaisedButton(
                                                                color:
                                                                    Colors.red,
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                            const Spacer(),
                                                            RaisedButton(
                                                              color:
                                                                  Colors.indigo,
                                                              child: const Text(
                                                                "Update",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                final form =
                                                                    _formKey
                                                                        .currentState;
                                                                if (form!
                                                                    .validate()) {
                                                                  form.save();

                                                                  await _update(
                                                                      shopkeys[
                                                                          index]);
                                                                  //print(singlerecord.keys);
                                                                  setState(() {
                                                                    fetchdatalist();
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
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
                        ],
                      ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => add_car_record()));
                },
                tooltip: 'Add Record',
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
