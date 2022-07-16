import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'manage_records.dart';

class add_record extends StatefulWidget {
  add_record({Key? key}) : super(key: key);
  @override
  _add_recordPageState createState() => _add_recordPageState();
}

class _add_recordPageState extends State<add_record> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => manage_record()));
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text("Add Record"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bike Record",
                style:
                    GoogleFonts.abrilFatface(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              BikeRecord(),
            ]),
      )),
    );
  }
}

class BikeRecord extends StatefulWidget {
  //RegisterPet({Key key}) : super(key: key);
  // static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _BikeRecordState createState() => _BikeRecordState();
}

class _BikeRecordState extends State<BikeRecord> {
  //late PickResult selectedPlace;
  final _formKey = GlobalKey<FormState>();
  final listOfServices = [
    "Mechanical",
    "Oil Change",
    "Electrical",
    "Denting and Painting",
    "Tire Shop",
    "Spare Parts"
  ];
  final OutdoorServices = ["Yes", "No"];
  final Rating = ["1", "2", "3", "4", "5"];
  final Affordability = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  String dropdownValue = 'Mechanical';
  String dropdownValue2 = 'Yes';
  String dropdownValue3 = '1';
  String dropdownValue4 = '1';

  final ON_Controller = TextEditingController();
  final SN_Controller = TextEditingController();
  final contact_Controller = TextEditingController();
  final location_Controller = TextEditingController();

  final service = TextEditingController();
  final outdoor = TextEditingController();
  final rating = TextEditingController();
  final affordability = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("Bike Record");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: TextFormField(
                controller: ON_Controller,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Owner Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Owner Name';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: TextFormField(
                controller: SN_Controller,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_balance),
                    labelText: 'Shop Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Shop Name';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: TextFormField(
                controller: contact_Controller,
                decoration: InputDecoration(
                    icon: Icon(Icons.call),
                    labelText: 'Contact',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Contact';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: TextFormField(
                controller: location_Controller,
                decoration: InputDecoration(
                    icon: Icon(Icons.location_on_outlined),
                    labelText: 'Location',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Location';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              value: dropdownValue,
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              decoration: InputDecoration(
                labelText: "Select Service Once at a time",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: listOfServices.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownValue = newValue!;
                setState(() {
                  dropdownValue = newValue;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              value: dropdownValue2,
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              decoration: InputDecoration(
                labelText: "Outdoor Service",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: OutdoorServices.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownValue2 = newValue!;
                setState(() {
                  dropdownValue2 = newValue;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              value: dropdownValue3,
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              decoration: InputDecoration(
                hintText: 'Max. value means Max. afforable',
                labelText: "Rating",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: Rating.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownValue3 = newValue!;
                setState(() {
                  dropdownValue3 = newValue;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              value: dropdownValue4,
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              decoration: InputDecoration(
                hintText: 'Max. value means Max. afforable',
                labelText: "Affordability",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: Affordability.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownValue4 = newValue!;
                setState(() {
                  dropdownValue4 = newValue;
                });
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map map = {
                          "Shop Owner Name": ON_Controller.text,
                          "Shop Name": SN_Controller.text,
                          "Contact": contact_Controller.text,
                          "Location": location_Controller.text,
                          "Service": dropdownValue,
                          "Outdoor Service": dropdownValue2,
                          "Shop Rating": dropdownValue3,
                          "Affordability": dropdownValue4,
                        };
                        dbRef.push().set(map).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Added')));
                          ON_Controller.clear();
                          SN_Controller.clear();
                          contact_Controller.clear();
                          location_Controller.clear();
                          service.clear();
                          outdoor.clear();
                          rating.clear();
                          affordability.clear();
                        }).catchError((onError) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(onError)));
                        });
                      }
                    },
                    child: Text('Save Record'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.indigo),
                    ),
                  ),
                ],
              )),
        ])));
  }

  @override
  void dispose() {
    super.dispose();
    ON_Controller.dispose();
    SN_Controller.dispose();
    contact_Controller.dispose();
    location_Controller.dispose();
    service.dispose();
    outdoor.dispose();
    rating.dispose();
    affordability.dispose();
  }
}
