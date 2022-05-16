
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_car_record.dart';
import 'excelwork.dart';

class AddRecord extends StatelessWidget {
  const AddRecord({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final dbRef = FirebaseDatabase.instance.reference().child("Admin");
  String fileType = 'All';
  var fileTypeList = ['json'];
  FilePickerResult? result;
  PlatformFile? file;
  final String f="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=> add_car_record())); },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.indigo,title: Text('Record',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),),
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
            SizedBox(height: 40,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              ),
              onPressed: () async {
                pickFiles(fileType);


              },
              child: Text('Choose file',style: TextStyle(fontSize: 17),),
            ),
            if (file != null) fileDetails(file!),
            if (file != null)
              ElevatedButton(onPressed: (){
                SnackBar(content: Text('Successfully uploaded'));
                Customer.readExcel(file!.path as String);
                SnackBar(content: Text('Successfully uploaded'));
              },child: Text('Upload File')),
          ],
        ),
      ),
    );
  }
  Widget fileDetails(PlatformFile file){
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
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