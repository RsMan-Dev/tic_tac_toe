import 'dart:math';

import 'package:flutter/material.dart';

class ShakeCurve extends Curve {
  final double count;
  final double offset;

  const ShakeCurve({
    this.count = 2.0,
    this.offset = 0.0,
  });

  @override
  double transformInternal(double t) {
    return sin((2 * pi * count * t) + offset);
  }
}
