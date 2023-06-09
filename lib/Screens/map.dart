import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  String latitudeData = "";
  String longitudeData = "";
  var lat;
  var lon;

  static const _initial = CameraPosition(
    target: LatLng(30.0309724, 72.3112265),
    zoom: 11.5,
  );
  //late GoogleMapController _googlemapcontroller;
  void dispose() {
    // _googlemapcontroller.dispose();
    super.dispose();
  }

  Future<bool> getCurrentlocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        latitudeData = '${geoposition.latitude}';
        longitudeData = '${geoposition.longitude}';
        lat = double.parse(latitudeData);
        lon = double.parse(longitudeData);
        // print(latitudeData);
        // print(longitudeData);
        _marker.add(Marker(
          markerId: const MarkerId('id-1'),
          position: LatLng(lat, lon),
          icon: mapMarker,
          infoWindow: const InfoWindow(
            title: 'Your Current Location',
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
    //fetchdata();
  }

  Set<String> service = {};
  List fetchshopslist = [];
  List<String> Services = [
    'electrical',
    'mechanical',
    'oil change',
    'air conditioner',
    'spare parts',
    'denting and painting',
    'battery',
    'tire',
    'wash'
  ];
  // void fetchdata() async {
  //   dynamic newresult = FirebaseFirestore.instance
  //       .collection("shops")
  //       .where("Shop status", isEqualTo: true)
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       //print(result.data());

  //       fetchshopslist.add(result.data());
  //       service.add(result.data()['Service']);
  //       print(fetchshopslist.length);
  //       if (fetchshopslist.isEmpty) {
  //         record = true;
  //         if (mounted) {
  //           setState(() {
  //             searchshopslist = [];
  //           });
  //         }
  //         CoolAlert.show(
  //           context: context,
  //           type: CoolAlertType.info,
  //           text: "No Shop found",
  //         );
  //       } else if (fetchshopslist.isNotEmpty) {
  //         record = false;
  //         _loading = false;
  //         setState(() {});
  //         if (fetchshopslist.length > 9) {
  //           count = true;
  //         } else {
  //           count = false;
  //         }
  //       }
  //     });
  //   });
  // }

  bool count = true;
  Set<Marker> _marker = {};
  late BitmapDescriptor mapMarker, mapMarker2;
  void setCustomeMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'images/location_map.png');
    mapMarker2 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'images/location_m.png');
  }

  void _onMapCreated(GoogleMapController _googlemapcontroller) {
    setState(() {});
  }

  final List<String> _suggestions = [
    'electrical',
    'mechanical',
    'oil change',
    'tire',
    'spare parts',
    'denting and painting',
    'wheel alignment',
    'air conditioner',
    'battery',
    'wash'
  ];

  List searchshopslist = [];

  late String split;
  var shoplat, shoplon;

  Future<dynamic> shoplist(String value) async {
    searchshopslist = [];
    String searchtxt = _searchController.text.trim();
    setState(() {
      searchtxt = searchtxt.toLowerCase();
    });
    if (searchtxt.isNotEmpty) {
      value = searchtxt;
    }
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: value)
        .where("Shop status", isEqualTo: true)
        .get()
        .then((querySnapshot) {
      int Mid = 0;
      _marker.clear();

      querySnapshot.docs.forEach((result) {
        searchshopslist.add(result.data());
        if (searchshopslist.isEmpty) {
        } else {
          if (searchshopslist.length > 99) {
            count = true;
          } else {
            count = false;
          }
        }
        Mid++;
        split = '${result.data()["Location"]}';
        var position = split.split(",");

        if (mounted) {
          setState(() {
            shoplat = double.parse(position[0]);
            shoplon = double.parse(position[1]);
            _marker.add(Marker(
              markerId: MarkerId("$Mid"),
              position: LatLng(shoplat, shoplon),
              //onTap: _onMarkerTapped(),
              icon: mapMarker2,
              infoWindow: InfoWindow(
                  title: '${result.data()["Shop Name"]}',
                  snippet: 'Rating: ${result.data()["Shop Rating"]}',
                  onTap: () {
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
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text(
                                      "Shop details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "------------------------------",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 250,
                                          child: Text(
                                            "Owner Name: ${result.data()['Owner Name']}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Shop Type: ${result.data()['type']}")),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Service: ${result.data()['Service']}")),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Outdoor Service: ${result.data()['Outdoor Services']}")),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Outdoor Service Rate: ${result.data()['Rate']}")),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Affordability: ${result.data()['Shop Affordability']}")),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RatingBar.builder(
                                        //glowColor: Colors.amber,
                                        unratedColor: Colors.amber,
                                        direction: Axis.horizontal,
                                        itemCount: result.data()['Shop Rating'],
                                        itemSize: 18.0,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        FlutterPhoneDirectCaller.callNumber(
                                            '0${result.data()['Contact']}');
                                      },
                                      icon: const Icon(Icons.call_rounded),
                                      color: Colors.green,
                                      iconSize: 35,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ));
          });
        }
      });
    });
  }

  TextEditingController _searchController = TextEditingController();

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: getCurrentlocation(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _initial,
                    onMapCreated: _onMapCreated,
                    markers: _marker,
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
          // EasySearchBar(
          //     backgroundColor: Colors.white,
          //     title: const Text(""),
          //     onSearch: (value) => setState(() {
          //           _searchController.text = value;
          //           shoplist();

          //           //_pressed = true;
          //           //setState(() {});
          //         }),
          //     asyncSuggestions: (value) async =>
          //         await _fetchSuggestions(value)),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  if (_searchController.text.isEmpty)
                    IconButton(
                      splashColor: Colors.grey,
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      splashColor: Colors.grey,
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search..."),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () async {
                            await shoplist(_searchController.text);
                          },
                          icon: const Icon(Icons.arrow_right))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: SizedBox(
              height: 60,
              //width: 200,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Services.length,
                    itemBuilder: (context, index) => TextButton(
                      onPressed: () async {
                        setState(() {});
                        await shoplist(Services[index]);
                      },
                      child: Container(
                        // color: Colors.red,
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: const Offset(
                            //         0, 3), // changes position of shadow
                            //   ),
                            // ],
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            Services[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),

          // _loading == true
          //     ? Center(
          //         child: Container(
          //           height: 14,
          //           width: 14,
          //           child: const CircularProgressIndicator(
          //             strokeWidth: 3,
          //             backgroundColor: Color.fromARGB(255, 247, 121, 3),
          //             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //           ),
          //         ),
          //       )
          //     : count == false
          //         ? Padding(
          //             padding: const EdgeInsets.only(top: 25),
          //             child: SizedBox(
          //               height: 70,
          //               child: Container(
          //                 //alignment: Alignment.topRight,
          //                 padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          //                 decoration: const BoxDecoration(
          //                     //color: Colors.white,
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(20))),
          //                 child: Text(
          //                   "Shops=${searchshopslist.length}",
          //                   style: const TextStyle(
          //                     fontSize: 15,
          //                     color: Colors.indigo,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         : Container(
          //             padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          //             decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(Radius.circular(20))),
          //             child: const Text(
          //               "99+",
          //               style: TextStyle(
          //                 fontSize: 15,
          //                 color: Colors.indigo,
          //               ),
          //             )),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(255, 2, 145, 170),
      //   foregroundColor: Colors.white,
      //   onPressed: () => _googlemapcontroller
      //       .animateCamera(CameraUpdate.newCameraPosition(_initial)),
      //   child: const Icon(Icons.center_focus_strong),
      // ),
    );
  }
}
