import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../bottom_navbar/three_in_one.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ThreeInOne()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/logo.png',
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
          )),
          const Text(
            "CoinKeeper",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 88, 88, 85),
                fontSize: 30),
          ),
          const Text("Balancing Your Money",
              style: TextStyle(color: Color.fromARGB(255, 121, 119, 116))),
          LoadingAnimationWidget.newtonCradle(
            color: const Color.fromARGB(255, 81, 83, 82),
            size: 100,
          )
        ],
      ),
    );
  }
}
