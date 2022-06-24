import 'package:advance_notification/advance_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Startup/login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _key = GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();

  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter Your Email for Reset Password",
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Email Address",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                String pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                RegExp regExp = RegExp(pattern);
                if (value!.isEmpty) {
                  return 'Please enter email';
                } else if (!regExp.hasMatch(value)) {
                  return 'Please enter valid email Address';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                minimumSize: Size.fromHeight(40),
              ),
              icon: const Icon(
                Icons.password,
                size: 24,
              ),
              label: const Text(
                "Reset Password",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                await _ResetPassword();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _ResetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.text.trim(),
      );
      const AdvanceSnackBar(
              message: "Password Reset sent to your email",
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
      Navigator.of(context).pop();
      // Navigator.pop(context);
      navigatorkey.currentState?.popUntil((route) => route.isFirst);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
