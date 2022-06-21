import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
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
    fetchdata();
  }

  Set<String> service = {};
  List fetchshopslist = [];
  void fetchdata() async {
    dynamic newresult = FirebaseFirestore.instance
        .collection("shops")
        .where("Shop status", isEqualTo: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());

        fetchshopslist.add(result.data());
        service.add(result.data()['Service']);
        print(fetchshopslist.length);
        if (fetchshopslist.isEmpty) {
          record = true;
          if (mounted) {
            setState(() {
              searchshopslist = [];
            });
          }
        } else if (fetchshopslist.isNotEmpty) {
          record = false;
          _loading = false;
          setState(() {});
        }
      });
    });
  }

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
  bool record = false;
  bool _pressed = false;
  bool _loading = false;
  late String split;
  var shoplat, shoplon;

  Future<dynamic> shoplist(String value) async {
    String searchtxt = _searchController.text.trim();
    setState(() {
      searchtxt = searchtxt.toLowerCase();
    });

    _loading = true;
    dynamic newresult = await FirebaseFirestore.instance
        .collection("shops")
        .where("Service", isEqualTo: value)
        .where("Shop status", isEqualTo: true)
        .get()
        .then((querySnapshot) {
      int Mid = 0;
      _marker.clear();

      querySnapshot.docs.forEach((result) {
        Mid++;
        split = '${result.data()["Location"]}';
        var position = split.split(",");
        record = false;
        _loading = false;
        if (mounted) {
          setState(() {
            shoplat = double.parse(position[0]);
            shoplon = double.parse(position[1]);
            _marker.add(Marker(
              markerId: MarkerId("$Mid"),
              position: LatLng(shoplat, shoplon),
              icon: mapMarker2,
              infoWindow: const InfoWindow(
                title: 'Shop Location',
                snippet: 'Destination Place',
              ),
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
                    child: SpinKitFadingFour(
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
                  IconButton(
                    splashColor: Colors.grey,
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search..."),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 2, 145, 170),
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: SizedBox(
              height: 60,
              //width: 200,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: service.length,
                    itemBuilder: (context, index) => TextButton(
                      onPressed: () async {
                        setState(() {});
                        await shoplist(fetchshopslist[index]["Service"]);
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
                            "${fetchshopslist[index]["Service"]}",
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
