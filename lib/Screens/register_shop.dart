import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SendEmail.dart';

class register_shop extends StatefulWidget {
  const register_shop({Key? key}) : super(key: key);

  @override
  State<register_shop> createState() => _register_shopState();
}

class _register_shopState extends State<register_shop> {
  void initState() {
    super.initState();
    fetchadmindetail();
  }

  List adminlist = [];
  fetchadmindetail() async {
    List lisofrecord = [];
    await FirebaseFirestore.instance
        .collection("admin")
        .get()
        .then((QuerySnapshot) {
      QuerySnapshot.docs.forEach((result) {
        // print(result.data());
        lisofrecord.add(result);
        if (lisofrecord.isNotEmpty) {
          first == false;
          loading = false;
          if (mounted) {
            setState(() {});
          }
          adminlist = lisofrecord;
        } else {
          first = true;
          if (mounted) {
            setState(() {});
          }
        }
      });
    });
  }

  Future<void> _refresh() async {
    setState(() {});
    await fetchadmindetail();
  }

  @override
  bool first = true;
  bool loading = true;
  Widget build(BuildContext context) {
    if (first) {
      fetchadmindetail();
    }
    return Scaffold(
      body: loading == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("no admin exists"),
                SizedBox(
                  height: 30,
                ),
                SpinKitThreeBounce(
                  color: Color.fromARGB(255, 2, 145, 170),
                  size: 50.0,
                ),
              ],
            )
          : ListView(
              padding: const EdgeInsets.all(15),
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 30,
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  //color:Color(0xFF37474F),
                  height: 40,
                  //color: Colors.amber[100],
                  child: Text(
                    "Register Your Shops",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      minWidth: double.infinity,
                      maxHeight: 570),
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(255, 2, 145, 170),
                    //displacement: 100,
                    strokeWidth: 2,
                    edgeOffset: 20,
                    child: ListView.builder(
                        itemCount: adminlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            // color: Colors.black12,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("${adminlist[index]["admin_name"]}"),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        FlutterPhoneDirectCaller.callNumber(
                                            "0${adminlist[index]["admin_contact"]}");
                                      },
                                      icon: const Icon(Icons.call_rounded),
                                      color: Colors.green,
                                      iconSize: 25,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "E-mail us",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.contact_mail_outlined),
                                    const SizedBox(width: 5),
                                    Text("${adminlist[index]["admin_email"]}"),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        // final url =
                                        //     'mailto: ${adminlist[index]["admin_email"]}';
                                        // final Uri link = Uri.parse(url);

                                        // if (await canLaunchUrl(link)) {
                                        //   await launch(url);
                                        // } else {
                                        //   debugPrint("Error, Email not fetched");
                                        // }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SendEmail(
                                                  adminlist[index].id,
                                                  adminlist[index].data()),
                                            ));
                                      },
                                      icon: const Icon(Icons.mail),
                                      color: Colors.green,
                                      iconSize: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
    );
  }
}
