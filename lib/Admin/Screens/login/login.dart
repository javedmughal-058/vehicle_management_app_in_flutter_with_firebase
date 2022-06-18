import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Authentication/utils.dart';
import 'package:vehicle_maintainance/Admin/Screens/register/register.dart';
import 'package:vehicle_maintainance/Admin/components/background.dart';

import '../Authentication/AuthenticationService.dart';
import '../Main/admin_home.dart';
import '../Main/main_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();

  //AuthenticationService _auth = AuthenticationService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  bool loading = true;

  Future _login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      // Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const main_page()));
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar(e.message);
    }

    navigatorkey.currentState?.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return main_page();
              } else {
                return Background(
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2661FA),
                                fontSize: 36),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: email,
                            decoration:
                                const InputDecoration(labelText: "Email"),
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
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: password,
                            decoration:
                                const InputDecoration(labelText: "Password"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password can\'t be empty';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                                fontSize: 12, color: Color(0XFF2661FA)),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: RaisedButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                _login();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  gradient: const LinearGradient(colors: [
                                    Colors.indigo,
                                    Colors.blue,
                                  ])),
                              padding: const EdgeInsets.all(0),
                              child: const Text(
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()))
                            },
                            child: const Text(
                              "Don't Have an Account? Sign up",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2661FA)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
