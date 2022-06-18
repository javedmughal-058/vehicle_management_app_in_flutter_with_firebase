import 'package:advance_notification/advance_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Authentication/utils.dart';
import 'package:vehicle_maintainance/Admin/Screens/login/login.dart';
import 'package:vehicle_maintainance/Admin/components/background.dart';
import 'package:email_validator/email_validator.dart';
import '../Main/main_page.dart';

class RegisterScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _saveadmin() {}

    Future _signup() async {
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (context) => const Center(
      //           child: CircularProgressIndicator(),
      //         ));
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        String? id;
        final user = FirebaseAuth.instance.currentUser;
        DocumentReference dc =
            FirebaseFirestore.instance.collection("admin").doc(user!.uid);
        Map<String, dynamic> adminRecord = {
          "admin_name": name.text,
          "admin_contact": contact.text,
          "admin_email": email.text,
        };
        dc
            .set(adminRecord)
            .whenComplete(() => print("${name.text} Registered"));
      } on FirebaseAuthException catch (e) {
        print(e);
        //Utils.showSnackBar(e.message);
      }
      const AdvanceSnackBar(
              message: "Successfully register ",
              duration: Duration(seconds: 3),
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

      //navigatorkey.currentState?.popUntil((route) => route.isFirst);
    }

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Background(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: "Name"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name can\'t be empty';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (email) =>
                          email != null && EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: contact,
                    decoration: const InputDecoration(
                      labelText: "Contact",
                      hintText: 'Enter number without 0',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                      RegExp regExp = RegExp(pattern);
                      if (value!.isEmpty) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(labelText: "Password"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter atlest 6 characters'
                        : null,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                RaisedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await _signup();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => main_page()));
                      name.clear();
                      email.clear();
                      password.clear();
                      contact.clear();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: const LinearGradient(colors: [
                          Colors.indigo,
                          Colors.blue,
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: const Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: const Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
