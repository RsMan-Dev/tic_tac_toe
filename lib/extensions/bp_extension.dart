import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

extension StateExtension on State {
  T bp<T>({
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) =>
      context.layout.value(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
      );
}

extension StatelessExtension on StatelessWidget {
  T bp<T>(
    BuildContext context, {
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) =>
      context.layout.value(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
      );
}
