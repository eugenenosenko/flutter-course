import 'package:flutter/material.dart';

class BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        horizontal: 100.0,
        vertical: 25.0,
      ),
      color: Color(0xff4F2EFA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      onPressed: () {},
      child: Text('Start booking',
          style: TextStyle(color: Colors.white, fontSize: 26.0)),
    );
  }
}