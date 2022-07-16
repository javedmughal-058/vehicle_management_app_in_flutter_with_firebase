import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class detail_screen extends StatefulWidget {
  Map shop;
  var shopkey;
  detail_screen(this.shopkey, this.shop, {Key? key}) : super(key: key);

  @override
  _detail_screenState createState() =>
      _detail_screenState(this.shopkey, this.shop);
}

class _detail_screenState extends State<detail_screen> {
  _detail_screenState(this.shopkey, this.singlerecord) {}

  Set<Marker> _marker = {};
  late BitmapDescriptor mapMarker, mapMarker2;

  String latitudeData = "";
  String longitudeData = "";
  var _cuurentlat, shoplat;
  var _currentlon, shoplon;

  bool Ratingcall = false;
  static const _initial = CameraPosition(
    target: LatLng(30.0309724, 72.3412265),
    zoom: 10.5,
  );
  //late GoogleMapController _googlemapcontroller;
  void dispose() {
    // _googlemapcontroller.dispose();
    super.dispose();
  }

  Future<bool> getCurrentlocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    split = '${singlerecord["Location"]}';
    var position = split.split(",");
    //print(position);

    if (mounted) {
      setState(() {
        //Current location
        latitudeData = '${geoposition.latitude}';
        longitudeData = '${geoposition.longitude}';
        _cuurentlat = double.parse(latitudeData);
        _currentlon = double.parse(longitudeData);
        //Shop location
        shoplat = double.parse(position[0]);
        shoplon = double.parse(position[1]);
        // print(latitudeData);
        // print(longitudeData);
        _marker.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(shoplat, shoplon),
          icon: mapMarker2,
          infoWindow: InfoWindow(
            title: '${singlerecord["Shop Name"]}',
            snippet: 'Service: ${singlerecord["Service"]}',
          ),
        ));
        _marker.add(Marker(
          markerId: const MarkerId('id-2'),
          position: LatLng(_cuurentlat, _currentlon),
          icon: mapMarker,
          infoWindow: const InfoWindow(
            title: 'Current Location',
            snippet: 'Place',
          ),
        ));
      });
    }
    return true;
  }

  void initState() {
    super.initState();
    getCurrentlocation();
    setCustomeMarker();
    //_position();
  }

  void setCustomeMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'images/location_map.png');
    mapMarker2 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'images/location_m.png');
  }

  void _onMapCreated(GoogleMapController _googlemapcontroller) {
    setState(() {});
  }

  late String reporter_name, complaint;
  late double reporter_contact;
  Map singlerecord;
  var shopkey;
  final _formKey = GlobalKey<FormState>();
  TextEditingController r_name = TextEditingController();
  TextEditingController r_contact = TextEditingController();
  TextEditingController r_complaint = TextEditingController();

  final complainttypelist = [
    "Missbehaveior",
    "Time consuming",
    "Attitude",
    "Wrong Location",
    "بکواس سٹاف"
  ];
  getreporterName(repotername) {
    this.reporter_name = repotername;
  }

  getreporterContact(reportercontact) {
    this.reporter_contact = double.parse(reportercontact);
  }

  getcomplaint(complaintdetail) {
    this.complaint = complaintdetail;
  }

  submitcomplaint() async {
    DocumentReference dc =
        FirebaseFirestore.instance.collection("complaints").doc(shopkey);
    Map<String, dynamic> complaints = {
      "complaint": complaint,
      "reporter_name": reporter_name,
      "reporter_contact": reporter_contact,
      "complainted_shop": shopkey,
      "Shop Name": singlerecord['Shop Name'],
      "Owner Name": singlerecord['Owner Name'],
      "Owner Contact": singlerecord['Contact'],
      "Shop Rating": singlerecord['Shop Rating'],
      "Shop Affordability": singlerecord['Shop Affordability'],
      "Shop Type": singlerecord['type'],
      "Shop Service": singlerecord['Service'],
    };
    dc.set(complaints).whenComplete(() {
      //print("Compliant submitted");
      setState(() {});
      const AdvanceSnackBar(
              message: "Successfully Submit Complaint",
              duration: Duration(seconds: 3),
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
    });
  }

  late String split;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Detail'),
        backgroundColor: const Color.fromARGB(255, 2, 145, 170),
        leading: Image.asset("images/app_icon.png"),
        actions: [
          PopupMenuButton(
            //  color: Colors.yellowAccent,
            elevation: 20,

            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.report_problem,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Complaint"),
                  ],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.star_border_outlined,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Rating"),
                  ],
                ),
                value: 2,
              ),
            ],
            onSelected: (value) {
              value == 1
                  ? showDialog(
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: r_name,
                                        decoration: const InputDecoration(
                                          labelText: 'Your Name',
                                          icon: Icon(Icons.person),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter Name';
                                          }
                                          return null;
                                        },
                                        onChanged: (String repotername) {
                                          getreporterName(repotername);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: r_contact,
                                        decoration: const InputDecoration(
                                          labelText: 'Contact',
                                          hintText: 'Enter number without 0',
                                          icon: Icon(Icons.phone),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          String pattern =
                                              r'(^(?:[+0]9)?[0-9]{10}$)';
                                          RegExp regExp = RegExp(pattern);
                                          if (value!.isEmpty) {
                                            return 'Please enter mobile number';
                                          } else if (!regExp.hasMatch(value)) {
                                            return 'Please enter valid mobile number';
                                          }
                                          return null;
                                        },
                                        onChanged: (String reportercontact) {
                                          getreporterContact(reportercontact);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: r_complaint,
                                        decoration: const InputDecoration(
                                          labelText: 'Enter Message',
                                          icon: Icon(Icons.message_outlined),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return value.length < 100
                                                ? 'complaint\'s message must \n minimum 100 characters'
                                                : null;
                                          }
                                        },
                                        onChanged: (String complaintdetail) {
                                          getcomplaint(complaintdetail);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          RaisedButton(
                                              color: Colors.red,
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                          const Spacer(),
                                          RaisedButton(
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color.fromARGB(
                                                255, 2, 145, 170),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                //print(singlerecord.keys);
                                                submitcomplaint();
                                                r_name.clear();
                                                r_contact.clear();
                                                r_complaint.clear();
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
                      })
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 200,
                            child: Stack(
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      const Text(
                                        "Rate us",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: RatingBar.builder(
                                          //glowColor: Colors.amber,
                                          unratedColor: Colors.grey,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemSize: 40.0,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            getRating(rating);

                                            //print(rating);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          color: const Color.fromARGB(
                                              255, 2, 145, 170),
                                          child: const Text("Submit"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            const AdvanceSnackBar(
                                                    message:
                                                        "Successfully submit rating",
                                                    duration:
                                                        Duration(seconds: 2),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2),
                                                      child: Icon(
                                                        Icons.all_inbox,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    isIcon: true)
                                                .show(context);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getCurrentlocation(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 100, maxHeight: 350),
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: _initial,
                      onMapCreated: _onMapCreated,
                      markers: _marker,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 9,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Shop Owner ',
                              style: GoogleFonts.merriweather(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey,
                            //   radius: 30.0,
                            //   child: Image.asset(
                            //     "images/admin.png",
                            //     height: 70,
                            //   ),
                            // ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                '${singlerecord['Owner Name']}',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                                style: GoogleFonts.merriweather(fontSize: 16),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                //print(shopkey);
                                FlutterPhoneDirectCaller.callNumber(
                                    '0${singlerecord['Contact']}');
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
                  Container(
                    padding: const EdgeInsets.all(15),
                    constraints:
                        const BoxConstraints(minHeight: 100, maxHeight: 290),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Shop Name",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 170,
                              child: Text(
                                '${singlerecord['Shop Name']}',
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Shop Type",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                                width: 170,
                                child: Text(
                                  '${singlerecord['type']}',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Service",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                                width: 170,
                                child: Text(
                                  '${singlerecord['Service']}',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Outdoor Service",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                                width: 170,
                                child: Text(
                                  '${singlerecord['Outdoor Services']}',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Rs/km",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                                width: 170,
                                child: Text(
                                  '${singlerecord['Rate']}',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Rating",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 170,
                              child: RatingBar.builder(
                                //allowHalfRating: true,

                                //glowColor: Colors.amber,
                                unratedColor: Colors.amber,
                                direction: Axis.horizontal,
                                itemCount: singlerecord['Shop Rating'],
                                itemSize: 18.0,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  //print(rating);
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              "Affordability",
                              style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            SizedBox(
                                width: 170,
                                child: Text(
                                  '${singlerecord['Shop Affordability']}',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Color.fromARGB(255, 2, 145, 170),
                  size: 50.0,
                ),
              );
            }
          })),
    );
  }

  late double feedbackrating;
  getRating(double rating) {
    this.feedbackrating = rating;
    rating = (rating + singlerecord['Shop Rating']) / 2;
    int newrating = rating.ceil();
    FirebaseFirestore.instance.collection("shops").doc(shopkey).update({
      'Shop Rating': newrating,
    }).then((_) {
      print("successfully update!");
    }).catchError((error) => print('updation failed: $error'));
  }
}
