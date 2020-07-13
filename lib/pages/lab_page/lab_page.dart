import 'dart:math' as math;

import 'package:flutter/material.dart';

class LabPage extends StatefulWidget {
  @override
  _LabPageState createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> {
  final _keyUnderscore = GlobalKey();
  final _keyRooms = GlobalKey();
  final _keyPrice = GlobalKey();
  final _keyPersonal = GlobalKey();

  double _leftMovingMargin;
  double _roomsPosition;
  double _pricePosition;
  double _personalPosition;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);
    super.initState();
  }

  void _getSizes(Duration _) {
    final RenderBox renderBoxRed = _keyRooms.currentContext.findRenderObject();
    final RenderBox renderBoxRed1 = _keyPrice.currentContext.findRenderObject();
    final RenderBox renderBoxRed2 =
        _keyPersonal.currentContext.findRenderObject();

    _roomsPosition = renderBoxRed.localToGlobal(Offset.zero).dx;
    _pricePosition = renderBoxRed1.localToGlobal(Offset.zero).dx;
    _personalPosition = renderBoxRed2.localToGlobal(Offset.zero).dx;
    _leftMovingMargin = _roomsPosition;
  }

  double get indicatorGap => math.pi / 12;

  double get indicatorLength => math.pi / 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            clipper: _MyClipper(),
            child: Container(
              margin: EdgeInsets.only(bottom: 50.0),
              width: double.infinity,
              color: Colors.blueGrey,
              height: 300,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _leftMovingMargin = _roomsPosition;
                    });
                  },
                  child: Text(
                    'Rooms',
                    key: _keyRooms,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _leftMovingMargin = _pricePosition;
                    });
                  },
                  child: Text(
                    'Price',
                    key: _keyPrice,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _leftMovingMargin = _personalPosition;
                    });
                  },
                  child: Text(
                    'Personal',
                    key: _keyPersonal,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          _leftMovingMargin == null
              ? Container(
                  height: 7,
                )
              : AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.bounceOut,
                  margin: EdgeInsets.only(left: _leftMovingMargin),
                  width: 30,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
          SizedBox(height: 100),
          Center(
            child: Container(
                margin: EdgeInsets.all(12.0),
                width: 80,
                height: 80,
                child: CustomPaint(
                  painter: _PageIndicatorPainter(
                    startAngle: (4 * indicatorLength) -
                        (indicatorLength + indicatorGap),
                    sweepAngle: indicatorLength,
                  ),
                  child: CustomPaint(
                    painter: _PageIndicatorPainter(
                      startAngle: 4 * indicatorLength,
                      sweepAngle: indicatorLength,
                    ),
                    child: CustomPaint(
                      painter: _PageIndicatorPainter(
                        startAngle: (4 * indicatorLength) +
                            (indicatorLength + indicatorGap),
                        sweepAngle: indicatorLength,
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    return Path()
      ..lineTo(0.0, 200.0)
      ..quadraticBezierTo(size.width / 2.2, 260.0, size.width, 170.0)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class _PageIndicatorPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  Color paintColor;

  _PageIndicatorPainter({
    @required this.startAngle,
    @required this.sweepAngle,
    this.paintColor = Colors.blueGrey,
  })  : assert(startAngle != null),
        assert(sweepAngle != null);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..color = paintColor;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
