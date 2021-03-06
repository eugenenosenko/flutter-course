import 'package:flutter/material.dart';
// import 'package:flutterportoflioapp/pages/my_animated_switcher/my_animated_switcher.dart';
// import 'package:flutterportoflioapp/pages/landing_page/landing_page.dart';
// import 'package:flutterportoflioapp/pages/my_animated_switcher/my_animated_switcher.dart';

 import 'package:flutterportoflioapp/pages/gmail_page/gmail_page.dart';
import 'package:flutterportoflioapp/pages/hotel_onboarding_page/hotel_onboarding_page.dart';

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MyApp();
  }
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HotelOnBoardingPage(),
    );
  }
}

