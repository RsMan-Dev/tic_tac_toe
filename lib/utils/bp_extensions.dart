import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

extension StateExtension on State {
  T bp<T>({
    required T xs,
    required T sm,
    required T md,
    required T lg,
    required T xl,
  }) =>
      context.layout.value(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
      );
}

extension StatefulExtension on StatelessWidget {
  T bp<T>(
    context, {
    required T xs,
    required T sm,
    required T md,
    required T lg,
    required T xl,
  }) =>
      context.layout.value(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
      );
}
