import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadiusGeometry radius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  const RoundedBox(
      {super.key,
      required this.child,
      this.color = Colors.white,
      this.radius = BorderRadius.zero,
      this.padding = EdgeInsets.zero,
      this.margin = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
      ),
      child: child,
    );
  }
}
