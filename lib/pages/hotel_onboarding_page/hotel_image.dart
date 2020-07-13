import 'package:flutter/material.dart';
import 'package:flutterportoflioapp/pages/hotel_onboarding_page/hotel_onboarding_page.dart';
import 'package:provider/provider.dart';

class HotelImage extends StatelessWidget {
  final String imagePath = 'assets/images/monocrome-building.jpg';

  @override
  Widget build(BuildContext context) {
    return Consumer<PageControllerNotifier>(
      builder: (context, notifier, child) {
        return Positioned(
          top: -300,
          left: -notifier.offset * 0.15,
          width: 500,
          child: Image.asset(imagePath),
        );
      },
    );
  }
}
