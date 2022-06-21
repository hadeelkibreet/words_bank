import 'dart:async';
import 'package:flutter/material.dart';
import 'package:w/shared/google_sheets_api.dart';
import '../main.dart';
import '../widget/components.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
    //GoogleSheetsApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: MediaQuery.of(context).size.width * 0.8,
          height:  MediaQuery.of(context).size.height * 0.8,
        ),
      ),
    );
  }

  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    if (sharedPref.getString("id_user") == null) {
      navigatorFinish(context, const LoginScreen());
    } else {
      navigatorFinish(context, const HomeScreen());
    }
  }
}
