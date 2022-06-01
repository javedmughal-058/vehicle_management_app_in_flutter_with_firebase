import 'package:advance_notification/advance_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Authentication/utils.dart';
import 'package:vehicle_maintainance/Admin/Screens/login/login.dart';
import 'package:vehicle_maintainance/Admin/components/background.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

      // navigatorkey.currentState!.popUntil((route) => route.isFirst);
    }

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
              SizedBox(height: size.height * 0.03),
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
              SizedBox(height: size.height * 0.03),
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
              SizedBox(height: size.height * 0.03),
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
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      _signup();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                      name.clear();
                      email.clear();
                      password.clear();
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
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
