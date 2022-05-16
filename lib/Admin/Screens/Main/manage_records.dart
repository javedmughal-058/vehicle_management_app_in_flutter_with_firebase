import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/add_car_record.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/view_record.dart';

import 'add_record.dart';
class manage_record extends StatefulWidget {
  const manage_record({Key? key}) : super(key: key);

  @override
  _manage_recordState createState() => _manage_recordState();
}

class _manage_recordState extends State<manage_record> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(90.0),
                  bottomLeft: Radius.circular(90.0)
                ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.indigo,
                ],
              ),
            ),
            child: Image.asset("images/main2.png"),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>add_car_record()));
                },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.red,
                    height: 140,
                    width: 120,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white
                    ),
                    child:  Column(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.add_box_outlined,size: 50,color: Colors.indigo,),
                        SizedBox(height: 20,),
                        Text('Add Record',textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),),
                      ],

                    ),
                  ),),
                TextButton(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const view_record()));

                },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.red,
                    height: 140,
                    width: 120,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white
                    ),
                    child:  Column(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.remove_red_eye,size: 50,color: Colors.indigo,),
                        SizedBox(height: 20,),
                        Text('View Record',textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),),
                      ],

                    ),
                  ),),
              ],
            ),
          ),
          //Divider(thickness: 1,color: Colors.indigo,),
        ],
      ),
    );
  }
}
