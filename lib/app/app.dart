import 'package:flutter/material.dart';
import 'package:flutterportoflioapp/pages/landing_page/landing_page.dart';

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
      home: LandingPage(),
    );
  }
}
