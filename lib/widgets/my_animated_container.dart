import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterportoflioapp/utils/random_utils.dart';

class MyAnimatedContainer extends StatefulWidget {
  // timer, properties, setstate
  @override
  _MyAnimatedContainerState createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<MyAnimatedContainer> {
  double _height = 200;
  double _width = 200;
  double _borderRadius = 20;
  Timer _timer;

  static final _random = Random();

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _height = _random.nextInt(300).toDouble();
        _width = _random.nextInt(100).toDouble();
        _borderRadius = _random.nextInt(100).toDouble();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          color: randomPrimaryColor(),
          borderRadius: BorderRadius.circular(_borderRadius)),
    );
  }
}
