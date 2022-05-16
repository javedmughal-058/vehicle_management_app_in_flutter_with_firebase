import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/login/login.dart';
import 'package:vehicle_maintainance/Admin/components/background.dart';

class RegisterScreen extends StatelessWidget {
  final _key=GlobalKey<FormState>();
  TextEditingController name=  TextEditingController();
  TextEditingController email=  TextEditingController();
  TextEditingController password=  TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Form(

          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                    controller: name,
                  decoration: InputDecoration(
                    labelText: "Name"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),

              SizedBox(height: size.height * 0.05),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                      if(_key.currentState!.validate()){
                        try {
                          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,


                          );
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user!= null && !user.emailVerified) {
                            await user.sendEmailVerification();
                          }

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                        name.clear();
                        email.clear();
                        password.clear();
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                        colors: [
                          Colors.indigo,
                          Colors.blue,
                        ]
                      )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}