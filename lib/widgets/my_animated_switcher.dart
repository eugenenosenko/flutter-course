import 'dart:async';

import 'package:flutter/material.dart';

class MyAnimatedSwitcher extends StatefulWidget {
  @override
  _MyAnimatedSwitcherState createState() => _MyAnimatedSwitcherState();
}

class _MyAnimatedSwitcherState extends State<MyAnimatedSwitcher> {
  Timer _timer;
  int counter = 0;
  Widget _child = Container(
    width: 200,
    height: 200,
    color: Colors.redAccent,
  );

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        print('${timer.tick}');
        _child = MyContainer(
          key: ValueKey(timer.tick),
        );
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
    return Scaffold(
      body: Center(
          child: AnimatedSwitcher(
              transitionBuilder: (widget, animation) {
                final offsetAnimation = TweenSequence([
                  TweenSequenceItem(
                      tween: Tween<Offset>(
                          begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)),
                      weight: 1),
                  TweenSequenceItem(
                      tween: ConstantTween(Offset(0.0, 0.0)), weight: 2),
                  TweenSequenceItem(
                      tween: Tween<Offset>(
                          begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0)),
                      weight: 1)
                ]).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeTransition(
                      opacity: animation,
                      child: RotationTransition(
                        turns: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: widget,
                        ),
                      ),
                    ),
                  ),
                );
              },
              duration: Duration(seconds: 3),
              child: _child)),
    );
  }
}

class MyContainer extends StatelessWidget {
  final int item;

  const MyContainer({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(item),
      height: 200,
      width: 200,
      color: Colors.redAccent,
    );
  }
}
