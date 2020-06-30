import 'package:flutter/material.dart';
import 'package:flutterportoflioapp/utils/random_utils.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: randomPrimaryColor(),
        )
      ),
    );
  }
}
