import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_maintainance/Screens/introduction/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> _backgroundHandler(RemoteMessage message) async {
  print(message.data);
  if(message.notification != null){
    print(message.notification!.title);
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  return runApp(
    const MaterialApp(
      title: ' SplashScreen ',
      debugShowCheckedModeBanner: false,
      home: SplashScreenOne(),
    ),
  );
}

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenOneState();
  }
}

class SplashScreenOneState extends State<SplashScreenOne> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 2, 145, 170),
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromARGB(255, 2, 145, 170),
              //     Color.fromARGB(255, 253, 253, 253),
              //   ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 243, 243, 243),
                //backgroundColor: Colors.transparent,
                radius: 100.0,
                backgroundImage: AssetImage('images/app_icon.png'),
                //child: Image.asset("images/app_icon.png"),
              ),
              const Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              ),
              SizedBox(
                width: 260.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText('Vehicle Maintenance App'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnBoardingPage()));
  }
}
