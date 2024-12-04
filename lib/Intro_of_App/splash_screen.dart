import 'package:chatt_app/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screen copy.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initiate();
  }

  Future<void> initiate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checkfirst = prefs.getBool('first');
    Timer(Duration(seconds: 6), () {
      if (checkfirst == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
        prefs.setBool('first', true);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });

    setState(() {
      checkfirst = prefs.getBool('first');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB52121),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "Images/SVG Burger _ Menu.gif",
              height: 300,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
