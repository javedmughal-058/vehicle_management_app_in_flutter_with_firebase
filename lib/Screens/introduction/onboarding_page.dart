import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vehicle_maintainance/Screens/homepage.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Facility of Google Map',
                body:
                    'User can search shop on map and find the exact location of shop.',
                image: buildImage('images/googlemap.jfif'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Rating and Affordability.',
                body:
                    'User can search shops by rating filter or affordability filter. With help of these filters users can filtered their results according to need.',
                image: buildImage('images/affordable.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Simple UI',
                body:
                    'Easy to understand interface for enhanced reading experience.',
                image: buildImage('images/manthumbs.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Feedback',
                body:
                    'User will able to give Rating to shops. By Rating, Ranking of shop will change.',
                image: buildImage('images/feedback.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Register Your Shop',
                body:
                    'You are able to contact to admin and send your shop details.',
                // footer: ButtonWidget(
                //   text: 'Start Reading',
                //   onClicked: () => goToHome(context),
                // ),
                image: buildImage('images/contact.png'),
                decoration: getPageDecoration(),
              ),
            ],
            done: const Text('Next',
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 145, 170),
                    fontWeight: FontWeight.w600)),
            onDone: () => goToHome(context),
            showSkipButton: true,
            skip: const Text(
              'Skip',
              style: TextStyle(color: Color.fromARGB(255, 2, 145, 170)),
            ),
            onSkip: () => goToHome(context),
            next: const Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 2, 145, 170),
            ),
            dotsDecorator: getDotDecoration(),
            //onChange: (index) => print('Page $index selected'),
            globalBackgroundColor: Colors.white,
            // isProgressTap: false,
            // isProgress: false,
            // showNextButton: false,
            // freeze: true,
            // animationDuration: 1000,
          ),
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => main_page()),
      );

  Widget buildImage(String path) => ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Center(child: Image.asset(path, width: 350)));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: Color.fromARGB(255, 2, 145, 170),
        size: Size(8, 8),
        activeSize: Size(16, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: GoogleFonts.courgette(
          fontSize: 20,
        ),
        bodyPadding: EdgeInsets.all(24),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
