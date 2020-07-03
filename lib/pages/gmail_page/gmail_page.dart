import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GmailPage extends StatefulWidget {
  @override
  _GmailPageState createState() => _GmailPageState();
}

class _GmailPageState extends State<GmailPage> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          print('Im scrolling in reverse direction');
        } else if (_controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          print('Im scrolling forward');
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildEmailTiles(),
            _buildComposeButton(),
            Positioned(
              top: 10,
              left: 7,
              child: Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned _buildComposeButton() {
    return Positioned(
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
    );
  }

  Widget _buildEmailTiles() {
    return ListView.builder(
      controller: _controller,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return SizedBox(height: 70);
        }

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
    );
  }
}
