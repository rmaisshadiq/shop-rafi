import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_rafi/login.dart';
import 'package:shop_rafi/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstRun();
  }

  Future<void> _checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        if (isFirstRun) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoarding()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/images/tokopedia.png', scale: 1.2)),
    );
  }
}
