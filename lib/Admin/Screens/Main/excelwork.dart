import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:firebase_database/firebase_database.dart';

class Customer {
  static void readExcel(String path) {
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

  static void upload(var list) async {
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
  }
}
