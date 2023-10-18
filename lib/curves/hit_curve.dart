import 'package:flutter/material.dart';

class HitCurve extends Curve {
  @override
  double transformInternal(double t) {
    var v = 0.0;
    if (t < 0.25) {
      v = Curves.easeOut.transformInternal(t * 4);
    } else {
      v = Curves.easeInOut.transform(1 - ((t - 0.25) * (4 / 3)));
    }
    return v;
  }
}
