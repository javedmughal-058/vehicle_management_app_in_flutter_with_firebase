import 'package:flutter/material.dart';
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

  Future<dynamic> getCurrentlocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        latitudeData = '${geoposition.latitude}';
        longitudeData = '${geoposition.longitude}';
        lat = double.parse(latitudeData);
        lon = double.parse(longitudeData);
        print(latitudeData);
        print(longitudeData);
        _marker.add(const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(30.0309724, 72.3112265),
          //icon: mapMarker,
          infoWindow: InfoWindow(
            title: 'COMSATS University Islamabad,\n Vehari Campus',
            snippet: 'Education Place',
          ),
        ));
        _marker.add(Marker(
          markerId: const MarkerId('id-2'),
          position: LatLng(lat, lon),
          //icon: mapMarker,
          infoWindow: const InfoWindow(
            title: 'COMSATS University Islamabad,\n Vehari Campus',
            snippet: 'Education Place',
          ),
        ));
      });
    }
  }

  void initState() {
    super.initState();
    getCurrentlocation();
    //setCustomeMarker();
  }

  Set<Marker> _marker = {};
  late BitmapDescriptor mapMarker;
  void setCustomeMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'images/location.png');
  }

  void _onMapCreated(GoogleMapController _googlemapcontroller) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initial,
            onMapCreated: _onMapCreated,
            markers: _marker,
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
