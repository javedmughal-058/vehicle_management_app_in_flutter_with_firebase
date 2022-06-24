import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Admin/Screens/Main/main_page.dart';
import '../Authentication/utils.dart';
import '../Main/main_page.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  bool verified = false;
  Timer? timer;
  bool canResendEmail = false;
  void initState() {
    super.initState();
    verified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!verified) {
      SendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checEmailVerified(),
      );
    }
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future SendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      print(e.toString());
      //Utils.showSnackBar(e.toString());
    }
  }

  Future checEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      verified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (verified) timer?.cancel();
  }

  Widget build(BuildContext context) => verified
      ? main_page()
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify Email"),
            backgroundColor: Colors.indigo,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "A verification Email has been sent to your email",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    minimumSize: Size.fromHeight(40),
                  ),
                  icon: const Icon(
                    Icons.cancel,
                    size: 24,
                  ),
                  label: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ),
              // TextButton(
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: Size.fromHeight(50),
              //   ),
              //   child: const Text(
              //     "Cancel",
              //     style: TextStyle(fontSize: 24, color: Colors.indigo),
              //   ),
              //   onPressed: () => FirebaseAuth.instance.signOut(),
              // )
            ],
          ),
        );
}
