import 'package:event_music_app/Constants/colors.dart';
import 'package:event_music_app/Views/Dashboard/bottomNavigation.dart';
import 'package:event_music_app/Views/loginScreen.dart';
import 'package:flutter/material.dart';

import '../Helper/shared_preference_helper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  void nextScreen() async {
    final sharedPrefHelper = SharedPreferenceHelper.instance();
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => sharedPrefHelper.isUserLoggedIn ? CustomNavigator() : LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
          child: Image.asset('assets/logo.jpeg')),
    );
  }
}
