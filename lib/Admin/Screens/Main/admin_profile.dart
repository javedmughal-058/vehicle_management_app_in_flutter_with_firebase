import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/privacy_policy.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/reports.dart';
import 'package:vehicle_maintainance/Admin/Screens/Startup/login.dart';

import 'block_shops.dart';

class admin_profile extends StatefulWidget {
  admin_profile({Key? key}) : super(key: key);

  @override
  _admin_profileState createState() => _admin_profileState();
}

class _admin_profileState extends State<admin_profile> {
  final user = FirebaseAuth.instance.currentUser;
  List blockedlist = [];
  List complaintlist = [];
  List adminRecord = [];
  //Map admin={};
  @override
  void initState() {
    super.initState();
    blockedshoplist();
    complaintshoplist();
    //fetchadmin();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();

  Future<bool> fetchadmin() async {
    //var useremail = user!.email.toString() + " ";

    List admindata = [];
    await FirebaseFirestore.instance
        .collection("admin")
        .doc(user!.email)
        .get()
        .then((value) {
      //print(Element.data());
      admindata.add(value.data());
      //print(admindata);
      if (admindata.isNotEmpty) {
        first = false;
        adminRecord = admindata;
        //print(adminRecord);
      } else {
        //first = true;

      }
    });
    return true;
  }

  Future updateProfile() async {
    await FirebaseFirestore.instance
        .collection("admin")
        .doc(user!.email)
        .update({
      "admin_name": name.text,
      "admin_contact": contact.text,
    }).then((value) {
      const AdvanceSnackBar(
              message: "Successfully Update",
              duration: Duration(seconds: 2),
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
      Navigator.of(context).pop();
    });
  }

  blockedshoplist() async {
    //print(user!.email);
    List lisofitem = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        //.orderBy("Shop Rating",descending: true)
        .where("Shop status", isEqualTo: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        lisofitem.add(result.data());
      });
    });
    if (lisofitem.isNotEmpty) {
      first = false;

      if (this.mounted) {
        setState(() {});
      }
      blockedlist = lisofitem;
    } else {
      first = true;
    }
  }

  complaintshoplist() async {
    List lisofcomplaint = [];
    dynamic newresult = await FirebaseFirestore.instance
        .collection("complaints")
        .orderBy('reporter_name', descending: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        lisofcomplaint.add(result.data());
      });
    });
    if (lisofcomplaint.isNotEmpty) {
      color = true;
      first = false;

      if (this.mounted) {
        setState(() {});
      }
      complaintlist = lisofcomplaint;
    } else {
      if (this.mounted) {
        setState(() {});
      }

      color = false;
      first = true;
    }
  }

  bool color = false;
  bool first = true;
  Future<void> _refresh() async {
    setState(() {});
    await fetchadmin();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      complaintshoplist();
      blockedshoplist();
    }
    return FutureBuilder(
        future: fetchadmin(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: Colors.white,
              backgroundColor: Colors.indigo,
              //displacement: 100,
              strokeWidth: 2,
              edgeOffset: 20,
              onRefresh: _refresh,
              child: ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   child: CircleAvatar(
                      //       radius: 30,
                      //       backgroundColor: Colors.black12,
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(50),
                      //         child: Image.asset("images/admin.png"),
                      //       )),
                      // ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${adminRecord[0]["admin_name"]}",
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Login as: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${user!.email}",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Update your profile",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      // overflow: Overflow.visible,
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
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: name,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Your Name',
                                                    icon: Icon(Icons.person),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Name';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: contact,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Contact',
                                                    hintText:
                                                        'Enter number without 0',
                                                    icon: Icon(Icons.phone),
                                                  ),
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    String pattern =
                                                        r'(^(?:[+0]9)?[0-9]{10}$)';
                                                    RegExp regExp =
                                                        RegExp(pattern);
                                                    if (value!.isEmpty) {
                                                      return 'Please enter mobile number';
                                                    } else if (!regExp
                                                        .hasMatch(value)) {
                                                      return 'Please enter valid mobile number';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    TextButton(
                                                        // color: Colors.red,
                                                        child: const Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                    const Spacer(),
                                                    TextButton(
                                                      child: const Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      // color: Colors.indigo,
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          await updateProfile();
                                                          name.clear();
                                                          contact.clear();
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
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.indigo,
                          )),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const block_shops()));
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.block_rounded),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    const Text("Blocked"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "(${blockedlist.length})",
                                      style: const TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.navigate_next)
                              ],
                            )),
                        const Divider(
                          thickness: 1,
                        ),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const reports()));
                            },
                            child: Row(
                              children: [
                                color == true
                                    ? Stack(
                                        children: [
                                          Icon(
                                            Icons.notifications_active_outlined,
                                            color: Colors.red,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              //padding: EdgeInsets.fromLTRB(4, 0,1, 0),
                                              child: Center(
                                                child: Text(
                                                  "${complaintlist.length}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              height: 14,
                                              width: 14,
                                            ),
                                          )
                                        ],
                                      )
                                    : const Icon(
                                        Icons.notifications_active_outlined),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("Requests"),
                                const Spacer(),
                                const Icon(Icons.navigate_next)
                              ],
                            )),
                        const Divider(
                          thickness: 1,
                        ),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => PrivacyPage()));
                            },
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(Icons.settings),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("Privacy Policy"),
                                const Spacer(),
                                const Icon(Icons.navigate_next)
                              ],
                            )),
                        const Divider(
                          thickness: 1,
                        ),
                        GestureDetector(
                            onTap: (){
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                              ));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Logout"),
                                Spacer(),
                                Icon(Icons.navigate_next)
                              ],
                            )),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Color.fromARGB(255, 247, 121, 3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }
        }));
  }
}
