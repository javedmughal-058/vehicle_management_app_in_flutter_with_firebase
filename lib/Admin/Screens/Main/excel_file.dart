import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_car_record.dart';

class AddRecord extends StatelessWidget {
  const AddRecord({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  bool uploaded = false;

  final dbRef = FirebaseDatabase.instance.reference().child("Admin");
  String fileType = 'All';
  var fileTypeList = ['json'];
  FilePickerResult? result;
  PlatformFile? file;
  final String f = "";
  void readExcel(String path) {
    var list = [];
    var file = path;
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      excel.tables[table]!.removeRow(0);
      for (var row in excel.tables[table]!.rows) {
        var items = [];
        for (var item in row) {
          try {
            items.add(item!.value);
          } catch (e) {}
        }
        if (items.isNotEmpty && items[2].toString().length == 10) {
          list.add(items);
        }
      }
    }
    upload(list);
    //print("");
  }

  void upload(var list) async {
    var existingShops = [];
    final ref = FirebaseFirestore.instance;

    await ref.collection('shops').get().then((value) {
      for (var item in value.docs) {
        String cont = item['Contact'].toString();
        String service = item['Service'].toString().toLowerCase();
        existingShops.add(cont + service);
      }
    });
    //print('abc');
    int count = 0;
    for (List item in list) {
      if (existingShops.isNotEmpty) {
        String cont = item[2].toString();
        String service = item[4].toString().toLowerCase();
        if (!existingShops.contains(cont + service)) {
          try {
            await ref.collection('shops').add({
              'Owner Name': item[0],
              'Shop Name': item[1],
              'Contact': item[2],
              'Location': item[3],
              'Service': item[4],
              'Outdoor Services': item[5],
              'Rate': item[6],
              'Shop Rating': item[7],
              'Shop Affordability': item[8],
              'Shop status': item[9],
              'type': item[10],
            });
            count++;
            print(count);
          } catch (e) {
            print('Error Occured 1');
          }
        }
      } else {
        try {
          await ref.collection('shops').add({
            'Owner Name': item[0],
            'Shop Name': item[1],
            'Contact': item[2],
            'Location': item[3],
            'Service': item[4],
            'Outdoor Services': item[5],
            'Rate': item[6],
            'Shop Rating': item[7],
            'Shop Affordability': item[8],
            'Shop status': item[9],
            'type': item[10],
          });
          count++;
          print(count);
        } catch (e) {
          print('Error Occured 2');
        }
      }
    }
    setState(() {
      _loading = false;
    });
    const AdvanceSnackBar(
            message: "Successfully upload excel record",
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => add_car_record()));
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          backgroundColor: Colors.indigo,
          title: Text(
            'Record',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Excel File ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo),
                ),
                onPressed: () async {
                  pickFiles(fileType);
                },
                child: Text(
                  'Choose file',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              if (file != null) fileDetails(file!),
              if (file != null)
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(65),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      minimumSize: Size.fromHeight(45),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      uploaded = true;
                      if (_loading) return;
                      setState(() {
                        _loading = true;
                      });
                      // const AdvanceSnackBar(
                      //         message: "Successfully upload excel record",
                      //         duration: Duration(seconds: 5),
                      //         child: Padding(
                      //           padding: EdgeInsets.only(left: 2),
                      //           child: Icon(
                      //             Icons.all_inbox,
                      //             color: Colors.red,
                      //             size: 25,
                      //           ),
                      //         ),
                      //         isIcon: true)
                      //     .show(context);
                      readExcel(file!.path as String);
                    },
                    child: _loading == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 3,
                                  backgroundColor:
                                      Color.fromARGB(255, 247, 121, 3),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Please wait...",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        : uploaded == true
                            ? Text(
                                'Uploaded',
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                'Upload File',
                                style: TextStyle(fontSize: 16),
                              ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fileDetails(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );
  }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'All':
        result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
        );
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
    }
  }
}
