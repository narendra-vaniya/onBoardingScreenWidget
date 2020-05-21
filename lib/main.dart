import 'package:flutter/material.dart';
import 'package:onboarding/onBoardingScreen.dart';

void main() => runApp(OnBoarding());

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Screen> _list = [
    Screen(
      imagePath: "lib/assets/home.png",
      headingText: "Choose an online store",
      subText:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    Screen(
      imagePath: "lib/assets/basket.png",
      headingText: "Find the right products",
      subText:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    Screen(
      imagePath: "lib/assets/card.png",
      headingText: "Register your credit card",
      subText:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen(
      screenList: _list,
      headingTextStyle: TextStyle(
          wordSpacing: 1,
          color: Color(0xFF552b81),
          fontWeight: FontWeight.bold,
          fontSize: 20),
      subTextStyle: TextStyle(
          wordSpacing: 1,
          color: Color(0xFF80709f),
          fontWeight: FontWeight.bold,
          fontSize: 13),
      //pageIndicatorColor: Colors.indigoAccent,
      pageIndicatorType: PageIndicatorType.circle,
      pageIndicatorSize: Size(20, 8),
      skipButton: Text(
        "Skip",
        style: TextStyle(fontSize: 15),
      ),
      onSkip: () {
        print("object");
      },
      nextButton: Text(
        "Next",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onDone: () {
        print("done");
      },
      doneButton: Text("GET STARTED"),
    );
  }
}
