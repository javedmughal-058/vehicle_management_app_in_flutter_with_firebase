import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  static const _initial = CameraPosition(
    target: LatLng(30.0309724, 72.3112265),
    zoom: 11.5,
  );
  late GoogleMapController _googlemapcontroller;
  void dispose() {
    _googlemapcontroller.dispose();
    super.dispose();
  }

  Set<Marker> _marker = {};
  void _onMapCreated(GoogleMapController _googlemapcontroller) {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(30.0309724, 72.3112265)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initial,
        onMapCreated: _onMapCreated,
        markers: _marker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 2, 145, 170),
        foregroundColor: Colors.white,
        onPressed: () => _googlemapcontroller
            .animateCamera(CameraUpdate.newCameraPosition(_initial)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
