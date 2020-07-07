import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterportoflioapp/pages/hotel_onboarding_page/booking_button.dart';
import 'package:flutterportoflioapp/pages/hotel_onboarding_page/hotel_image.dart';
import 'package:flutterportoflioapp/pages/hotel_onboarding_page/hotel_onboard_header.dart';
import 'package:provider/provider.dart';

class HotelOnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HotelOnBoardingContent(),
          SizedBox(height: 10.0),
          BookingButton()
        ],
      ),
    );
  }
}

class HotelOnBoardingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.3),
      margin: EdgeInsets.all(10.0),
      elevation: 15,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HotelOnboardingHeader(),
          HotelOnBoardPageView(),
        ],
      ),
    );
  }
}

class PageControllerNotifier with ChangeNotifier {
  double _offset = 0.0;
  double _page = 0.0;

  PageControllerNotifier(PageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;

  double get page => _page;
}

class HotelOnBoardPageView extends StatefulWidget {
  @override
  _HotelOnBoardPageViewState createState() => _HotelOnBoardPageViewState();
}

class _HotelOnBoardPageViewState extends State<HotelOnBoardPageView> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageControllerNotifier(_controller),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          children: <Widget>[
            HotelImage(),
            HotelOnboardingScrollableContentArea(_controller),
          ],
        ),
      ),
    );
  }
}

class HotelOnboardingScrollableContentArea extends StatelessWidget {
  final PageController _controller;

  HotelOnboardingScrollableContentArea(this._controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          height: 250,
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            )),
            color: Colors.white,
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: _buildPageView()
          ),
        ),
      ],
    );
  }

  PageView _buildPageView() {
    return PageView(
      controller: _controller,
      physics: ClampingScrollPhysics(),
      children: [
        PageCard(index: 0),
        PageCard(index: 1),
        PageCard(index: 2),
      ],
    );
  }
}

class PageCard extends StatelessWidget {
  final double index;

  const PageCard({@required this.index});

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageControllerNotifier>(context).page;
    print('$page');

    return AnimatedOpacity(
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 300),
      opacity: _calculateOpacity(page),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Experience Luxury\n\n',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: '''
              Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 
              '''
                  .trimLeft(),
              style: TextStyle(
                height: 1.6,
                fontSize: 15.0,
                wordSpacing: 2.0,
                color: Colors.grey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }

  double _calculateOpacity(double page) {
    if (index == page) {
      return 1;
    }

    if (page >= index + 0.1) {
      return 0;
    }

    if (page + 0.1 >= index) {
      return 1;
    }

    return 0;
  }
}
