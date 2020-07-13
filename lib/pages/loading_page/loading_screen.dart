import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingIndicatorPage extends StatefulWidget {
  @override
  _LoadingIndicatorPageState createState() => _LoadingIndicatorPageState();
}

class _LoadingIndicatorPageState extends State<LoadingIndicatorPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _rotationAnimation;
  Animation _arcContractAnimation;
  Animation _arcExpandAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        final arc2StartAngle = 0.5 * pi ;

        setState(() {
          if (_controller.value >= 0.75 && _controller.value <= 1.0) {
            _arc1StartAngle =
                lerpDouble(_arc1StartAngle, 0.5 * pi, _arcExpandAnimation.value);
            _arc1EndAngle =
                lerpDouble(_arc1EndAngle, -pi, _arcExpandAnimation.value);
            _arc2StartAngle = lerpDouble(
                _arc2StartAngle, 1.5 * pi, _arcExpandAnimation.value);
            _arc2EndAngle =
                lerpDouble(_arc2EndAngle, -pi, _arcExpandAnimation.value);
          } else if (_controller.value >= 0.0 && _controller.value <= 0.25) {
            _arc1StartAngle = lerpDouble(
                _arc1StartAngle, 0.25 * pi, _arcContractAnimation.value);
            _arc1EndAngle =
                lerpDouble(_arc1EndAngle, -pi / 2, _arcContractAnimation.value);
            _arc2StartAngle = lerpDouble(
                _arc2StartAngle, 1.25 * pi, _arcContractAnimation.value);
            _arc2EndAngle =
                lerpDouble(_arc2EndAngle, -pi / 2, _arcContractAnimation.value);
          }
        });
      });

    // 0.25 * pi, -pi / 2
    // 1.25 * pi, -pi / 2

    // .5 * pi, -pi
    // 1.5 * pi, -pi
    final initialRotations = 15 * pi;
    final endingRotations = 8 * pi;
    _rotationAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: initialRotations)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 85.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: initialRotations, end: endingRotations)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 15.0,
        ),
      ],
    ).animate(_controller);

    _arcContractAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.25, curve: Curves.easeOut),
    ));

    _arcExpandAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.75, 1, curve: Curves.easeOut),
    ));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _arc1StartAngle = 0.25 * pi;
  double _arc1EndAngle = -pi / 2;
  double _arc2StartAngle = 1.25 * pi;
  double _arc2EndAngle = -pi / 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
      ),
      body: Center(
          child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 0,
              ),
            ),
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: CustomPaint(
                painter: _MyPainter(
                  arc1StartAngle: _arc1StartAngle,
                  arc1EndAngle: _arc1EndAngle,
                  arc2StartAngle: _arc2StartAngle,
                  arc2EndAngle: _arc2EndAngle,
                  arc1Color: Colors.blue,
                  arc2Color: Colors.green,
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}

class _MyPainter extends CustomPainter {
  final double arc1StartAngle;
  final double arc1EndAngle;
  final double arc2EndAngle;
  final double arc2StartAngle;
  final Color arc1Color;
  final Color arc2Color;

  _MyPainter({
    this.arc1StartAngle = 0.25 * pi,
    this.arc1EndAngle = -pi,
    this.arc2StartAngle = 1.25 * pi,
    this.arc2EndAngle = -pi,
    this.arc1Color = Colors.blue,
    this.arc2Color = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arc1Paint = Paint()
      ..strokeWidth = 5
      ..color = arc1Color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arc2Paint = Paint()
      ..strokeWidth = 5
      ..color = arc2Color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arc3Paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arc4Paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.orangeAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arc5Paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.pinkAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arc6Paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.purpleAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Rect rect1 = new Rect.fromLTWH(0.0 + (0.15 * size.width),
        0.0 + (0.15 * size.height), size.width * 0.7, size.height * 0.7);
    Rect rect2 = new Rect.fromLTWH(0.0 + (0.3 * size.width),
        0.0 + (0.3 * size.height), size.width * 0.4, size.height * 0.4);

    canvas.drawArc(rect, arc1StartAngle, arc1EndAngle, false, arc1Paint);
    canvas.drawArc(rect, arc2StartAngle, arc2EndAngle, false, arc2Paint);

    canvas.drawArc(rect1, arc1StartAngle, arc1EndAngle, false, arc3Paint);
    canvas.drawArc(rect1, arc2StartAngle, arc2EndAngle, false, arc4Paint);

    canvas.drawArc(rect2, arc1StartAngle, arc1EndAngle, false, arc5Paint);
    canvas.drawArc(rect2, arc2StartAngle, arc2EndAngle, false, arc6Paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
