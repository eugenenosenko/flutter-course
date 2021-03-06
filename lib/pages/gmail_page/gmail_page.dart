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
  double _searchBarWidth = 380.0;
  double _searchBarHeight = 50.0;
  double _searchBarBorderRadius = 10.0;
  Widget _searchBarLeadingWidget = _buildLeadingSearchBarWidget(true);
  Widget _searchBarTrailingWidget = _buildTrailingSearchBarWidget(true);

  static Widget _buildLeadingSearchBarWidget(bool isDefault) {
    return AnimatedSwitcher(
      transitionBuilder: (widget, animation){
        return RotationTransition(
          turns: Tween<double>(begin: -0.25, end: 0.0).animate(animation),
          child: widget,
        );
      },
      duration: const Duration(milliseconds: 200),
      child: isDefault
          ? IconButton(
        key: UniqueKey(),
        onPressed: () {},
        icon: Icon(Icons.menu),
      )
          : IconButton(
        key: UniqueKey(),
        onPressed: () {},
        icon: Icon(Icons.arrow_back),
      ),
    );
  }

  static Widget _buildTrailingSearchBarWidget(bool isDefault) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isDefault
          ? const CircleAvatar(
        child: Text('EN'),
      )
          : IconButton(
        onPressed: () {},
        icon: Icon(Icons.mic_none),
      ),
    );
  }

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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 2000));
        } ,
        displacement: 150,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _buildEmailTiles(),
              _buildComposeButton(),
              _buildSearchBar()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
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
              _searchBarLeadingWidget = _buildLeadingSearchBarWidget(false);
              _searchBarTrailingWidget = _buildTrailingSearchBarWidget(false);
            } else {
              _searchBarHeight = 50;
              _searchBarWidth = 380;
              _searchBarBorderRadius = 10;
              _searchBarTopPosition = 10;
              _searchBarLeadingWidget = _buildLeadingSearchBarWidget(true);
              _searchBarTrailingWidget = _buildTrailingSearchBarWidget(true);
            }
          });
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _searchBarWidth,
            height: _searchBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_searchBarBorderRadius),
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _searchBarLeadingWidget,
                      const Expanded(child: Text('Search in mail')),
                      _searchBarTrailingWidget,
                    ],
                  ),
                ],
              ),
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
        duration: const Duration(milliseconds: 200),
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
      physics: const BouncingScrollPhysics(),
      controller: _controller,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return const SizedBox(height: 70);
        }

        return ListTile(
          leading: const CircleAvatar(
            child: Text('A'),
          ),
          title: const Text('Email Title'),
          subtitle: const Text('Short email description'),
          trailing: Column(
            children: <Widget>[const Text('Jul 1'), Icon(Icons.star_border)],
          ),
        );
      },
      itemCount: 30,
    );
  }
}
