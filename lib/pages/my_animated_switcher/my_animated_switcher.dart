import 'dart:async';

import 'package:flutter/material.dart';

class MyAnimatedSwitcherPage extends StatefulWidget {
  @override
  _MyAnimatedSwitcherPageState createState() => _MyAnimatedSwitcherPageState();
}

class _MyAnimatedSwitcherPageState extends State<MyAnimatedSwitcherPage> {
  Widget _child = _MyContainer();
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        print('${timer.tick}'); // 1 2 3 4 5
        _child = _MyContainer(
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
          layoutBuilder: (widget, previousWidgets) {
            return widget;
          },
          transitionBuilder: (widget, animation) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: RotationTransition(
                turns: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: widget,
                  ),
                ),
              ),
            );
          },
          duration: Duration(seconds: 3),
          child: _child,
        ),
      ),
    );
  }
}

class _MyContainer extends StatelessWidget {
  const _MyContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.redAccent,
    );
  }
}
