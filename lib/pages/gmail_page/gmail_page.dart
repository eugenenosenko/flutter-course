import 'package:flutter/material.dart';

class GmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemBuilder: (_, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('A'),
                  ),
                  title: Text('Email Title'),
                  subtitle: Text('Short email description'),
                  trailing: Column(
                    children: <Widget>[Text('Jul 1'), Icon(Icons.star_border)],
                  ),
                );
              },
              itemCount: 30,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              bottom: 40,
              right: 50,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Icon(
                  Icons.create,
                  color: Colors.redAccent,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
