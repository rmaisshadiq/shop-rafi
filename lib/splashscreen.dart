import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_rafi/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/images/tokopedia.png', scale: 1.2)),
    );
  }
}
