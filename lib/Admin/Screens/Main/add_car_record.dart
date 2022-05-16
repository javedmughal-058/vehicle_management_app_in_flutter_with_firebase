import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/excel_file.dart';
import 'admin_home.dart';


class add_car_record extends StatefulWidget {
  static final kInitialPosition = const LatLng(-33.8567844, 151.213108);

  add_car_record({Key? key}) : super(key: key);
  @override
  _add_car_recordPageState createState() =>  _add_car_recordPageState();
}
class _add_car_recordPageState extends State<add_car_record> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
          leading: Image.asset("images/main.png"),

        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),  //don't specify icon if you want 3 dot menu
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: const Text("import excel file",style: TextStyle(color: Colors.indigo),),
              ),
            ],
            onSelected: (item)  {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const AddRecord()));
            },
          ),
        ],
        title: const Text("Add Record"),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BikeRecord(),
                ]),
          )),
    );
  }
}

class BikeRecord extends StatefulWidget {
 @override
  _BikeRecordState createState() => _BikeRecordState();
}

class _BikeRecordState extends State<BikeRecord> {
  late PickResult selectedPlace;
  late String Ownername, shopname, shoplocation;
  String shopservice="Mechanical", OServices="Yes",record_name="bike";
  int shoprating=1,shopafffordability=1;
  late double ocontact;
  late double price_km=0;
  final bool status=true;
  bool drop=true;
  bool enable=false;

  getOwnerName(name){
    this.Ownername=name;
  }
  getShopName(sname){
    this.shopname=sname;
  }
  getOwnerContact(contact){
    this.ocontact=double.parse(contact);
  }
  getLocation(location){
    this.shoplocation=location;
  }
  getPrice(rate){
    this.price_km=double.parse(rate);
  }
  getdropdownValue(service) {
    this.shopservice=service;
  }
  getdropdownValue2(Outservice) {
    this.OServices=Outservice;
    if(OServices=="No"){
      enable=true;
    }
    else{
      enable=false;
    }

  }
  getdropdownValue3(rating) {
    this.shoprating=int.parse(rating);
  }
  getdropdownValue4(affordability) {
    this.shopafffordability=int.parse(affordability);
  }
  getdropdownValue5(newValueSelected) {
    this.record_name=newValueSelected;
    if(record_name=="wash" || record_name=="battery"){
      enable=true;
      shopservice=record_name;
      OServices="No";
      price_km=0;

    }else{
      enable=false;
    }
  }
  saveCarData() {
    //print("saved");

      String? uid;
      DocumentReference dc =FirebaseFirestore.instance.
      collection("shops").doc(uid);
      Map<String, dynamic> shops={
        "Owner Name": Ownername,
        "Shop Name": shopname,
        "Contact": ocontact,
        "Location": shoplocation,
        "Service": shopservice,
        "Outdoor Services": OServices,
        "Rs/km": price_km,
        "Shop Rating":shoprating,
        "Shop Affordability": shopafffordability,
        "Shop status":status,
        "type": record_name,
      };
      dc.set(shops).whenComplete((){
        //print("$Ownername Created");
        setState(() {
          dropdownValue = 'Mechanical';
          dropdownValue2 = 'Yes';
          dropdownValue3 = '1';
          dropdownValue4 = '1';
        });

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

      });

  }

  //late PickResult selectedPlace;
  final _formKey = GlobalKey<FormState>();
  final listOfServices = ["Mechanical", "Oil Change", "Electrical","Denting and Painting","Tire Shop","Spare Parts"];
  final OutdoorServices = ["Yes", "No"];
  final Rating=["1","2","3","4","5"];
  final Affordability = ["1", "2","3","4","5","6","7","8","9","10"];
  final categorylist= ["bike", "car","battery","wash"];
  String dropdownValue = 'Mechanical';
  String dropdownValue2 = 'Yes';
  String dropdownValue3 = '1';
  String dropdownValue4 = '1';
  String dropdownValue5='bike';

  final ON_Controller = TextEditingController();
  final SN_Controller = TextEditingController();
  final contact_Controller=TextEditingController();
  final location_Controller=TextEditingController();
  final price_controller=TextEditingController();

 // final dbRef = FirebaseDatabase.instance.reference().child("Bike Record");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  value: dropdownValue5,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  decoration: InputDecoration(
                    labelText: "Category",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: categorylist.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValueSelected) {
                    getdropdownValue5(newValueSelected);
                    // getService=(service);
                    setState(() {
                      dropdownValue5 = newValueSelected!;
                    });
                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: TextFormField(
                    controller: ON_Controller,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        labelText: 'Owner Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Owner Name';
                      }
                      return null;
                    },
                    onChanged: (String name){
                      getOwnerName(name);
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
                        icon: const Icon(Icons.account_balance),
                        labelText: 'Shop Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Shop Name';
                      }
                      return null;
                    },
                    onChanged: (String sname){
                      getShopName(sname);
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
                        icon: const Icon(Icons.call),
                        labelText: 'Contact',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Contact';
                      }
                      return null;
                    },
                    onChanged: (String contact){
                      getOwnerContact(contact);
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
                        icon: const Icon(Icons.location_on_outlined),
                        labelText: 'Location',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Location';
                      }
                      return null;
                    },
                    onChanged: (String location){
                      getLocation(location);
                    },
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: enable,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    decoration: InputDecoration(
                      labelText: "Select Service Once at a time",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    items: listOfServices.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? service) {
                     getdropdownValue(service);
                     // getService=(service);
                      setState(() {
                        dropdownValue = service!;
                      });
                    },

                  ),
                ),
              ),
              IgnorePointer(
                ignoring: enable,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField(
                    value: dropdownValue2,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    decoration: InputDecoration(
                      labelText: "Outdoor Service",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    items: OutdoorServices.map((String value) {
                      return  DropdownMenuItem<String>(
                        value: value,
                        child:  Text(value),
                      );
                    }).toList(),
                    onChanged: (String? Outservice) {
                      getdropdownValue2(Outservice);
                      // getService=(service);
                      setState(() {
                        dropdownValue2 = Outservice!;

                      });
                    },

                  ),
                ),
              ),
              IgnorePointer(
                ignoring: enable,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: TextFormField(
                      controller: price_controller,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.currency_rupee),
                          labelText: 'Rs/km',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      validator: (value) {
                        if (enable==false && value!.isEmpty) {
                          return 'Enter Rs/km';
                        }
                        return null;
                      },
                      onChanged: (String rate){
                        getPrice(rate);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(

                  value: dropdownValue3,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  decoration: InputDecoration(
                    hintText: 'Max. value means Max. afforable',
                    labelText: "Rating",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: Rating.map((String value) {
                    return  DropdownMenuItem<String>(
                      value:value,

                      child:  Text(value),
                    );
                  }).toList(),
                  onChanged: ( String? rating) {
                    getdropdownValue3(rating);
                    setState(() {
                      dropdownValue3 = rating!;
                    });
                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  value: dropdownValue4,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  decoration: InputDecoration(
                    hintText: 'Max. value means Max. afforable',
                    labelText: "Affordability",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: Affordability.map((String value) {
                    return  DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: ( String? affordability) {
                    getdropdownValue4(affordability);
                    setState(() {
                      dropdownValue4 = affordability!;
                    });
                  },

                ),
              ),

              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                         if(_formKey.currentState!.validate()) {
                           saveCarData();
                           ON_Controller.clear();
                           SN_Controller.clear();
                           contact_Controller.clear();
                           location_Controller.clear();
                           price_controller.clear();
                         }
                        },
                        child: const Text('Save Record'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
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
    price_controller.dispose();


  }
  }

 

