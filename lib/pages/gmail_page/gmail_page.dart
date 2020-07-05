import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GmailPage extends StatefulWidget {
  @override
  _GmailPageState createState() => _GmailPageState();
}

class _GmailPageState extends State<GmailPage> {
  ScrollController _controller;
  double _composeButtonWidth = 50.0;
  double _searchBarTopPosition = 10.0;
  Widget _composeButtonText = Container();
  Widget _searchBarLeftIconButton = _createMenuIconButton();
  Widget _searchBarRightIconButton = _createCircularAvatar();

  double _searchBarWidth = 380.0;
  double _searchBarHeight = 50.0;
  double _searchBarBorderRadius = 10.0;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          setState(() {
            _composeButtonWidth = 50.0;
            _composeButtonText = Container();
            _searchBarTopPosition = -50.0;
          });
        } else if (_controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          setState(() {
            _searchBarTopPosition = 10.0;
            _composeButtonWidth = 150;
            _composeButtonText = _buildComposeButtonText();
          });
        }
      });
    super.initState();
  }

  Widget _buildComposeButtonText() {
    return Expanded(
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

  Widget _buildSearchBar() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      top: _searchBarTopPosition,
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_searchBarHeight == 50) {
              _searchBarHeight = MediaQuery.of(context).size.height;
              _searchBarWidth = MediaQuery.of(context).size.width;
              _searchBarBorderRadius = 0.0;
              _searchBarTopPosition = 0.0;
              _searchBarLeftIconButton = _createBackIconButton();
              _searchBarRightIconButton = _createMicrophoneIconButton();
            } else {
              _searchBarHeight = 50;
              _searchBarWidth = 380;
              _searchBarBorderRadius = 10;
              _searchBarTopPosition = 10;
              _searchBarLeftIconButton = _createMenuIconButton();
              _searchBarRightIconButton = _createCircularAvatar();
            }
          });
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _searchBarWidth,
            height: _searchBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_searchBarBorderRadius),
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (widget, animation) {
                          return RotationTransition(
                            turns: Tween(begin: 0.5, end: 0.0).animate(animation),
                            child: widget,
                          );
                        },
                        child: _searchBarLeftIconButton,
                      ),
                      Expanded(
                        child: Text(
                          'Search in mail',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      AnimatedSwitcher(
                          transitionBuilder: (widget, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: widget,
                            );
                          },
                          duration: Duration(milliseconds: 200),
                          child: _searchBarRightIconButton)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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

  static Widget _createMenuIconButton() {
    return IconButton(
      key: ValueKey(Icons.mail.hashCode),
      icon: Icon(Icons.mail),
      onPressed: () {},
    );
  }

  static Widget _createBackIconButton() {
    return IconButton(
      key: ValueKey(Icons.arrow_back.hashCode),
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  static Widget _createCircularAvatar() {
    return CircleAvatar(
      child: Text('EN'),
    );
  }

  static Widget _createMicrophoneIconButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.mic_none),
    );
  }
}
