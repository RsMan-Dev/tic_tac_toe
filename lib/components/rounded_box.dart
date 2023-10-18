import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/theme.dart';

class RoundedBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadiusGeometry radius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final void Function()? onTap;
  const RoundedBox({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.radius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        color: color,
        borderRadius: radius,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: ThemeBuilder.primary.withOpacity(0.3),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
