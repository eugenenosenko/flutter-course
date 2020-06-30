import 'dart:math';

import 'package:flutter/material.dart';

final _random = Random();

Color randomPrimaryColor() {
  return Colors.primaries[_random.nextInt(Colors.primaries.length)];
}