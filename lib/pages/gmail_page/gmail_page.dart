import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GmailPage extends StatefulWidget {
  @override
  _GmailPageState createState() => _GmailPageState();
}

class _GmailPageState extends State<GmailPage> {
  ScrollController _controller;
  double _composeButtonWidth = 50.0;
  Widget _composeButtonText = Container();

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          setState(() {
            _composeButtonWidth = 50.0;
            _composeButtonText = Container();
          });
        } else if (_controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          setState(() {
            _composeButtonWidth = 150;
            _composeButtonText = Expanded(
              flex: 3,
              child: Text(
                'Compose',
                softWrap: false,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            );
          });
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
            _buildSearchBar()
          ],
        ),
      ),
    );
  }

  Positioned _buildSearchBar() {
    return Positioned(
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
    );
  }

  Positioned _buildComposeButton() {
    return Positioned(
      bottom: 40,
      right: 50,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _composeButtonWidth,
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Icon(
                Icons.create,
                color: Colors.redAccent,
                size: 26.0,
              ),
            ),
            _composeButtonText,
          ],
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
