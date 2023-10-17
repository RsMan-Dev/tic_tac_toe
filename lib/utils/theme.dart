import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/sizing.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle get toThin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get toExtraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get toLight => copyWith(fontWeight: FontWeight.w300);
  TextStyle get toRegular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get toMedium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get toSemiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get toBold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get toExtraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get toBlack => copyWith(fontWeight: FontWeight.w900);

  TextStyle get toUnderline => copyWith(decoration: TextDecoration.underline);
  TextStyle get toOverline => copyWith(decoration: TextDecoration.overline);
  TextStyle get toNoDecoration => copyWith(decoration: TextDecoration.none);

  TextStyle get toItalic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get toNormal => copyWith(fontStyle: FontStyle.normal);

  TextStyle get toSmaller => copyWith(fontSize: (fontSize ?? 16) * 0.8);
  TextStyle get toBigger => copyWith(fontSize: (fontSize ?? 16) * 1.2);
  TextStyle get toSmallest => copyWith(fontSize: (fontSize ?? 16) * 0.6);
  TextStyle get toBiggest => copyWith(fontSize: (fontSize ?? 16) * 1.4);

  TextStyle get toPrimary => copyWith(color: ThemeBuilder.primary);
  TextStyle get toOnPrimary => copyWith(color: ThemeBuilder.onPrimary);
  TextStyle get toSecondary => copyWith(color: ThemeBuilder.secondary);
  TextStyle get toOnSecondary => copyWith(color: ThemeBuilder.onSecondary);
  TextStyle get toError => copyWith(color: ThemeBuilder.error);
  TextStyle get toOnError => copyWith(color: ThemeBuilder.onError);
  TextStyle get toSuccess => copyWith(color: ThemeBuilder.success);
  TextStyle get toOnSuccess => copyWith(color: ThemeBuilder.onSuccess);
  TextStyle get toSurface => copyWith(color: ThemeBuilder.surface);
  TextStyle get toOnSurface => copyWith(color: ThemeBuilder.onSurface);
  TextStyle get toBackground => copyWith(color: ThemeBuilder.background);
  TextStyle get toOnBackground => copyWith(color: ThemeBuilder.onBackground);
  TextStyle get toTertiary => copyWith(color: ThemeBuilder.tertiary);
  TextStyle get toOnTertiary => copyWith(color: ThemeBuilder.onTertiary);
}

class _DefaultColors {
  _DefaultColors._();
  static Color get background => const Color(0xFFCBCED2);
  static Color get onBackground => primary;
  static Color get error => const Color(0xFFCC2929);
  static Color get onError => surface;
  static Color get success => const Color(0xFF1D9136);
  static Color get onSuccess => surface;
  static Color get info => const Color(0xFF1D78BA);
  static Color get onInfo => surface;
  static Color get primary => const Color(0xFF1D78BA);
  static Color get onPrimary => surface;
  static Color get secondary => const Color(0xFFC25618);
  static Color get onSecondary => surface;
  static Color get surface => const Color(0xFFFFFFFF);
  static Color get onSurface => onBackground;
  static Color get outline => const Color(0xFFD1D0D0);
  static Color get shadow => const Color.fromRGBO(118, 118, 125, 1);
}

class ThemeBuilder {
  ThemeBuilder._();
  @protected
  static ThemeData? _theme;
  static reset() {
    _theme = null;
  }

  static ThemeData get theme {
    _theme ??= ThemeData(
        useMaterial3: true,
        shadowColor: _DefaultColors.shadow,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          background: _DefaultColors.background,
          onBackground: _DefaultColors.onBackground,
          error: _DefaultColors.error,
          onError: _DefaultColors.onError,
          primary: _DefaultColors.primary,
          onPrimary: _DefaultColors.onPrimary,
          secondary: _DefaultColors.secondary,
          onSecondary: _DefaultColors.onSecondary,
          surface: _DefaultColors.surface,
          onSurface: _DefaultColors.onSurface,
          outline: _DefaultColors.outline,
          shadow: _DefaultColors.shadow,
        ),
        primaryColor: _DefaultColors.primary,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor: _DefaultColors.onPrimary,
          circularTrackColor: _DefaultColors.onPrimary,
          color: _DefaultColors.primary,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: Sizing.getWidthScaled(26),
              fontFamily: "Kensmark",
              fontWeight: FontWeight.w700,
              color: _DefaultColors.secondary),
          displayMedium: TextStyle(
              fontSize: Sizing.getWidthScaled(23),
              fontFamily: "Kensmark",
              fontWeight: FontWeight.w700,
              color: _DefaultColors.secondary),
          displaySmall: TextStyle(
              fontSize: Sizing.getWidthScaled(20),
              fontFamily: "Kensmark",
              fontWeight: FontWeight.w700,
              color: _DefaultColors.secondary),
          headlineMedium: TextStyle(
              fontSize: Sizing.getWidthScaled(18),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w700,
              color: _DefaultColors.secondary),
          headlineSmall: TextStyle(
              fontSize: Sizing.getWidthScaled(17),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w700,
              color: _DefaultColors.secondary),
          titleLarge: TextStyle(
              fontSize: Sizing.getWidthScaled(16),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w700,
              color: _DefaultColors.secondary),
          bodyLarge: TextStyle(
              fontSize: Sizing.getWidthScaled(16),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              color: _DefaultColors.onBackground),
          bodyMedium: TextStyle(
              fontSize: Sizing.getWidthScaled(14),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              color: _DefaultColors.onBackground),
          bodySmall: TextStyle(
              fontSize: Sizing.getWidthScaled(12),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              color: _DefaultColors.onBackground),
          labelLarge: TextStyle(
              fontSize: Sizing.getWidthScaled(16),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              color: _DefaultColors.onBackground),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: _DefaultColors.primary,
          selectionColor: _DefaultColors.primary.withOpacity(0.4),
          selectionHandleColor: _DefaultColors.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              fontSize: Sizing.getWidthScaled(14),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              color: _DefaultColors.secondary),
          errorStyle: TextStyle(
            fontSize: Sizing.getWidthScaled(14),
            fontFamily: "Avenir",
            fontWeight: FontWeight.w400,
            color: _DefaultColors.error,
            overflow: TextOverflow.ellipsis,
          ),
          errorMaxLines: 2,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          fillColor: _DefaultColors.background,
          filled: true,
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          contentPadding: EdgeInsets.symmetric(
            vertical: Sizing.getWidthScaled(10),
            horizontal: Sizing.getWidthScaled(15),
          ),
        ));
    return _theme!;
  }

  static get border => OutlineInputBorder(
        borderRadius: Sizing.borderRadius(all: 5),
        borderSide: BorderSide(color: _DefaultColors.outline, width: 1),
      );

  static InputDecorationTheme get inputDecoration => theme.inputDecorationTheme;

  static Color get primary => theme.colorScheme.primary;
  static Color get onPrimary => theme.colorScheme.onPrimary;
  static Color get secondary => theme.colorScheme.secondary;
  static Color get onSecondary => theme.colorScheme.onSecondary;
  static Color get error => theme.colorScheme.error;
  static Color get onError => theme.colorScheme.onError;
  static Color get success => _DefaultColors.success;
  static Color get onSuccess => _DefaultColors.onSuccess;
  static Color get info => _DefaultColors.info;
  static Color get onInfo => _DefaultColors.onInfo;
  static Color get surface => theme.colorScheme.surface;
  static Color get onSurface => theme.colorScheme.onSurface;
  static Color get background => theme.colorScheme.background;
  static Color get onBackground => theme.colorScheme.onBackground;
  static Color get tertiary => theme.colorScheme.tertiary;
  static Color get onTertiary => theme.colorScheme.onTertiary;
  static Color get outline => theme.colorScheme.outline;
  static Color get shadow => theme.colorScheme.shadow;

  static TextStyle get h1 => theme.textTheme.displayLarge!;
  static TextStyle get h2 => theme.textTheme.displayMedium!;
  static TextStyle get h3 => theme.textTheme.displaySmall!;
  static TextStyle get h4 => theme.textTheme.headlineMedium!;
  static TextStyle get h5 => theme.textTheme.headlineSmall!;
  static TextStyle get h6 => theme.textTheme.titleLarge!;
  static TextStyle get large => theme.textTheme.bodyLarge!;
  static TextStyle get text => theme.textTheme.bodyMedium!;
  static TextStyle get textBold => theme.textTheme.bodyMedium!.toBold;
  static TextStyle get small => theme.textTheme.bodySmall!;
  static TextStyle get button => theme.textTheme.labelLarge!;
  static TextStyle get link => theme.textTheme.bodyMedium!.toPrimary;

  static List<BoxShadow> get shadows => [
        BoxShadow(
          blurRadius: Sizing.getWidthScaled(18),
          offset: Sizing.offset(x: 5, y: 5),
          color: ThemeBuilder.shadow.withOpacity(0.1),
        )
      ];
  static List<BoxShadow> get shadowsDark => [
        BoxShadow(
          blurRadius: Sizing.getWidthScaled(18),
          offset: Sizing.offset(x: 5, y: 5),
          color: ThemeBuilder.shadow.withOpacity(0.3),
        )
      ];
}
