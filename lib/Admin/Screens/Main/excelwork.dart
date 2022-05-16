import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:firebase_database/firebase_database.dart';

class Customer{

  static void  readExcel(String path){
    var list=[];
    var file = path;
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      excel.tables[table]!.removeRow(0);
      for (var row in excel.tables[table]!.rows) {
        var items=[];
        for (var item in row)
        {
          try{items.add( item!.value);}
          catch(e){}

        }
        list.add(items);
      }
    }
    upload(list);
    //print("");

  }
  static void upload(var list)async {
    var contact = [];
    final ref = FirebaseDatabase.instance.reference();
    late DataSnapshot ds;
    ds = await ref.child("User").once().then((value) => value.snapshot);
    if (ds.exists && ds.value != null)
    {
      Map map=ds.value as Map;
      map.forEach((key, value) {
        contact.add(value['contact']);
      });
    }

    for (var item in list){
      if(contact.isNotEmpty){
        if(!contact.contains(item['contact'])){
          try{
            await ref.child("User").push().set({
              'Owner Name':item[0],
              'Shop Name':item[1],
              'Contact':item[2],
              'Location':item[3],
              'Service':item[4],
              'Outdoor Services':item[5],
              'Rs/km':item[6],
              'Shop Rating':item[7],
              'Shop Affordability':item[8],
              'Shop status':item[9],
              'type':item[10],
            });
          }
          catch (e){}}
      }
      else{
        try{
          await ref.child("User").push().set({
            'Owner Name':item[0],
            'Shop Name':item[1],
            'Contact':item[2],
            'Location':item[3],
            'Service':item[4],
            'Outdoor Services':item[5],
            'Rs/km':item[6],
            'Shop Rating':item[7],
            'Shop Affordability':item[8],
            'Shop status':item[9],
            'type':item[10],
          });
        }
        catch (e){}
      }
    }

  }
}