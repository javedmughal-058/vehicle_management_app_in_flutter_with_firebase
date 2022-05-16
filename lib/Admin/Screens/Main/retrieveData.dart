import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{
  List lisofitem=[];
  Future block()async{
    try{
      FirebaseFirestore.instance
          .collection("shops")
      //.orderBy("Shop Rating",descending: true)
          .where("Shop status", isEqualTo: false)
          .limit(1000)
          .get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {

          lisofitem.add(result.data());
        });
      });
      return lisofitem;
    }catch(e){
      print(e.toString());
      return null;
    }

  }
}

