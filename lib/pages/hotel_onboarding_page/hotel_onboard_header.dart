import 'package:flutter/material.dart';

class HotelOnboardingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('The',
                  style: TextStyle(
                    fontSize: 42.0,
                    color: Colors.white,
                  )),
              Text('Tranquil',
                  style: TextStyle(
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ],
          ),
          RotatedBox(
            quarterTurns: 1,
            child: RichText(
              text: TextSpan(children: [
                const  TextSpan(
                  text: 'DEFINING ',
                  style: TextStyle(fontSize: 14.0, letterSpacing: 1.2),
                ),
                TextSpan(
                  text: 'LUXURY',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    letterSpacing: 1.2,
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
