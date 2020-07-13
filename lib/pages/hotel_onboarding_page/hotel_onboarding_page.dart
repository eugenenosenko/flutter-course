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
          const SizedBox(height: 10.0),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      shadowColor: Colors.grey.withOpacity(0.3),
      margin: const EdgeInsets.all(10.0),
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
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: HotelOnboardingScrollableContentArea(_controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelOnboardingScrollableContentArea extends StatelessWidget {
  final PageController _controller;

  const HotelOnboardingScrollableContentArea(this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
      color: Colors.white,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll) {
                  overScroll.disallowGlow();
                  return false;
                },
                child: _buildPageView()),
          ),
          Expanded(flex: 1, child: PageProgressBar())
        ],
      ),
    );
  }

  PageView _buildPageView() {
    return PageView(
      controller: _controller,
      physics: const ClampingScrollPhysics(),
      children: const [
        PageCard(index: 0),
        PageCard(index: 1),
        PageCard(index: 2),
      ],
    );
  }
}

class PageProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        PageIndicator(0),
        PageIndicator(1),
        PageIndicator(2),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final double index;

  const PageIndicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageControllerNotifier>(builder: (_, notifier, child) {
      return Stack(
        children: <Widget>[
          Container(
            width: 95,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _calculateWidth(notifier.page),
            height: 3,
            color: const Color(0xff4F2EFA),
          )
        ],
      );
    });
  }

  double _calculateWidth(double page) {
    if (index == page) {
      return 95;
    }

    if (page >= index + 0.1) {
      return 0;
    }

    if (page + 0.1 >= index) {
      return 95;
    }

    return 0;
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

class GmailAppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PageCard extends StatelessWidget {
  final double index;

  const PageCard({@required this.index});

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageControllerNotifier>(context).page;
    return AnimatedOpacity(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
      opacity: _calculateOpacity(page),
      child: const PageText(),
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

class PageText extends StatelessWidget {
  const PageText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: RichText(
        text: const TextSpan(
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
              text:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the',
              style: TextStyle(
                height: 1.6,
                fontSize: 15.0,
                wordSpacing: 2.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
