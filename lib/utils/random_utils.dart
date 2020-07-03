import 'dart:math';

import 'package:flutter/material.dart';

final _random = Random();

Color randomPrimaryColor() {
  return Colors.primaries[_random.nextInt(Colors.primaries.length)];
}
//
//extension NumX<T extends num> on T {
//  T coerceAtMost(T maximumValue) => this > maximumValue ? maximumValue : this;
//}
