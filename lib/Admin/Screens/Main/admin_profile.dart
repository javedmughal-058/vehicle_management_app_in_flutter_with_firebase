import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/reports.dart';
import 'package:vehicle_maintainance/Admin/Screens/login/login.dart';

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
  @override
  void initState() {
    super.initState();
    blockedshoplist();
    complaintshoplist();
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
      });
    });
    if (lisofitem.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    if (first) {
      complaintshoplist();
      blockedshoplist();
    }
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("images/admin.png"),
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Admin Name",
                  style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FlatButton(
                  onPressed: () => {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("Login as"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Text("${user!.email}"),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              FlatButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const block_shops())),
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
              FlatButton(
                  onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const reports())),
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
                                        borderRadius: BorderRadius.all(
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
                          : const Icon(Icons.notifications_active_outlined),
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
              FlatButton(
                  onPressed: () => {},
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(Icons.settings),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("Setting"),
                      const Spacer(),
                      const Icon(Icons.navigate_next)
                    ],
                  )),
              const Divider(
                thickness: 1,
              ),
              FlatButton(
                  onPressed: () => {
                        FirebaseAuth.instance.signOut(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ))
                      },
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("Logout"),
                      const Spacer(),
                      const Icon(Icons.navigate_next)
                    ],
                  )),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
