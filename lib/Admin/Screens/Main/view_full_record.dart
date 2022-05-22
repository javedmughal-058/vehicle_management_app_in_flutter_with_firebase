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
  bool loading = true;
  late String record_name;
  List shopslist = [];
  List<String> shopkeys = [];
  @override
  void initState() {
    super.initState();
    fetchdatalist();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _shopname = TextEditingController();
  TextEditingController _ownername = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _shoptype = TextEditingController();
  TextEditingController _service = TextEditingController();
  TextEditingController _outdoor = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _rating = TextEditingController();
  TextEditingController _affordability = TextEditingController();
  TextEditingController _status = TextEditingController();

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
      print(value.data());
      singleshop.add(value.data());
    }).catchError((error) => print('Retrieve failed: $error'));
  }

  void _update(String shopkey) {
    FirebaseFirestore.instance.collection("shops").doc(shopkey).update({
      "Shop Name": _shopname.text.trim(),
      "Owner Name": _ownername,
      "Contact": _contact,
      "Location": _location,
      "type": _shoptype,
      "Service": _service,
      "Outdoor Services": _outdoor,
      "Rs/km": _rate,
      "Shop Rating": _rating,
      "Shop Affordability": _affordability,
      "Shop status": _status,
    }).then((_) {
      print("successfully update!");
    }).catchError((error) => print('updation failed: $error'));

    _shopname.clear();
    _ownername.clear();
    _contact.clear();
    _location.clear();
    _shoptype.clear();
    _service.clear();
    _outdoor.clear();
    _rating.clear();
    _affordability.clear();
    _rate.clear();
    _status.clear();
    const AdvanceSnackBar(
            message: "Successfully added record",
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

  void dispose() {
    super.dispose();
    _shopname.dispose();
    _ownername.dispose();
    _contact.dispose();
    _location.dispose();
    _shoptype.dispose();
    _service.dispose();
    _outdoor.dispose();
    _rating.dispose();
    _affordability.dispose();
    _rate.dispose();
    _status.dispose();
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
                      child: CircularProgressIndicator(
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
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Color.fromARGB(255, 247, 121, 3),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
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
                                onPressed: () async {
                                  await singlerecord(shopkeys[index]);

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
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const CircleAvatar(
                                                    child: Icon(Icons.close),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              Form(
                                                key: _formKey,
                                                child: ListView(
                                                  // mainAxisSize:
                                                  //     MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        controller: _shopname,
                                                        initialValue:
                                                            '${singleshop[index]['Shop Name']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Shop Name',
                                                          icon: Icon(
                                                              Icons.person),
                                                        ),

                                                        // onChanged: (String
                                                        //     repotername) {
                                                        //   getreporterName(
                                                        //       repotername);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _ownername,
                                                        initialValue:
                                                            '${singleshop[index]['Owner Name']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Owner Name',
                                                          icon:
                                                              Icon(Icons.phone),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Name';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     reportercontact) {
                                                        //   getreporterContact(
                                                        //       reportercontact);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        // controller: _contact,
                                                        initialValue:
                                                            '${singleshop[index]['Contact']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Owner Contact',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            if (value.isEmpty) {
                                                              return 'Enter Contact';
                                                            }
                                                            return null;
                                                          }
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _location,
                                                        initialValue:
                                                            '${singleshop[index]['Location']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Location',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'location';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _shoptype,
                                                        initialValue:
                                                            '${singleshop[index]['type']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Shop Type',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter type';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _service,
                                                        initialValue:
                                                            '${singleshop[index]['Service']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Shop Service',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Service';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _outdoor,
                                                        initialValue:
                                                            '${singleshop[index]['Outdoor Services']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText: 'yes/no',
                                                          labelText:
                                                              'Outdoor Service',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Mention yes/no';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _rate,
                                                        initialValue:
                                                            '${singleshop[index]['Rs/km']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Rs/km',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Rs/km';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller: _rating,
                                                        initialValue:
                                                            '${singleshop[index]['Shop Rating']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText: '(1-5)',
                                                          labelText:
                                                              'Shop Rating',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Rating';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        //controller:_affordability,
                                                        initialValue:
                                                            '${singleshop[index]['Shop Affordability']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText: '(1-10)',
                                                          labelText:
                                                              'Shop Affordability',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter Affordability';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        // controller: _status,
                                                        initialValue:
                                                            '${singleshop[index]['Shop status']}',
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'true/false',
                                                          labelText:
                                                              'Shop Status',
                                                          icon: Icon(Icons
                                                              .message_outlined),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter status';
                                                          }
                                                          return null;
                                                        },
                                                        // onChanged: (String
                                                        //     complaintdetail) {
                                                        //   getcomplaint(
                                                        //       complaintdetail);
                                                        // },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          RaisedButton(
                                                              child: const Text(
                                                                  "Cancel"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }),
                                                          const Spacer(),
                                                          RaisedButton(
                                                            child: const Text(
                                                                "Update"),
                                                            onPressed: () {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                //print(singlerecord.keys);
                                                                setState(() {
                                                                  loading =
                                                                      true;

                                                                  _update(
                                                                      shopkeys[
                                                                          index]);
                                                                  loading ==
                                                                          false
                                                                      ? Center(
                                                                          child:
                                                                              Container(
                                                                            //width: 120,height: 120,
                                                                            child:
                                                                                const CircularProgressIndicator(
                                                                              // backgroundColor: Colors.grey,
                                                                              strokeWidth: 7,
                                                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : fetchdatalist();
                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
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
