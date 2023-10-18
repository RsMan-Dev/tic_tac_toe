import 'package:flutter/material.dart';

class Matrix4TweenWithPerspective extends Matrix4Tween {
  final double perspective;
  final int perspectiveAxis;
  Matrix4TweenWithPerspective({
    required Matrix4 begin,
    required Matrix4 end,
    this.perspective = 0.001,
    this.perspectiveAxis = 2,
  }) : super(begin: begin, end: end);

  @override
  Matrix4 lerp(double t) {
    return (Matrix4.identity()..setEntry(3, perspectiveAxis, perspective)) *
        super.lerp(t);
  }
}
