import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mart_n_cart/Common/Constant.dart';
import 'package:mart_n_cart/Screens/HomeScreen.dart';
import 'package:mart_n_cart/Screens/LoginScreen.dart';
import 'package:mart_n_cart/transitions/fade_route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String phoneNumber = prefs.getString(Session.CustomerPhoneNo);
      if (phoneNumber == null) {
        Navigator.pushReplacement(context, FadeRoute(page: LoginScreen()));
      } else {
        Navigator.pushReplacement(context, FadeRoute(page: HomeScreen()));
      }
      print(phoneNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logomart.png',
          width: 215,
        ),
      ),
    );
  }
}
