import 'dart:math';

import 'package:flutter/material.dart';

enum MaterialAppTransitionType {
  //page will slide from left to right showing the new page
  slideRight,
  //page will slide from right to left showing the new page
  slideLeft,
  //page will slide from top to bottom showing the new page
  slideDown,
  //page will slide from bottom to top showing the new page
  slideUp,
  //page will slide from left to right showing the new page, new page will slide from right to left (attached to the old page's right side)
  slideRightSticky,
  //page will slide from right to left showing the new page, new page will slide from left to right (attached to the old page's left side)
  slideLeftSticky,
  //page will slide from top to bottom showing the new page, new page will slide from bottom to top (attached to the old page's bottom side)
  slideDownSticky,
  //page will slide from bottom to top showing the new page, new page will slide from top to bottom (attached to the old page's top side)
  slideUpSticky,
  //page will fade out showing the new page
  fade,
  //page will scale down to 0.9 and fade out showing the new page
  scaleOut,
  //new page will scale up from 0.9 to 1
  scaleIn,
  //page will scale up to 1.1 and fade out showing the new page
  scaleUpOut,
  //new page will scale down from 1.1 to 1
  scaleUpIn,
  //page will rotate clockwise, scale up and fade out showing the new page
  rotateOut,
  //new page will rotate clockwise, scale down and fade in
  rotateIn,
  //page will rotate counter-clockwise, scale up and fade out showing the new page
  rotateOutCounterClockwise,
  //new page will rotate counter-clockwise, scale down and fade in
  rotateInCounterClockwise,
  //new page will flip horizontally and fade in
  flipIn,
  //new page will flip vertically and fade in
  flipInY,
  //page will rotate in 3D like a cube from left to right with the new page on the other face
  cubeRotateRight,
  //page will rotate in 3D like a cube from right to left with the new page on the other face
  cubeRotateLeft,
  //page will rotate in 3D like a cube from top to bottom with the new page on the other face
  cubeRotateDown,
  //page will rotate in 3D like a cube from bottom to top with the new page on the other face
  cubeRotateUp,
  ;

  RouteTransitionsBuilder get transitionBuilder => switch (this) {
        slideRight => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(-1, 0), end: Offset.zero)
                .animate(animA),
            child: child),
        slideLeft => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animA),
            child: child),
        slideDown => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: Offset.zero)
                .animate(animA),
            child: child),
        slideUp => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animA),
            child: child),
        slideRightSticky => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(-1, 0), end: Offset.zero)
                .animate(animA),
            child: SlideTransition(
                position: Tween(begin: Offset.zero, end: const Offset(1, 0))
                    .animate(animB),
                child: child)),
        slideLeftSticky => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animA),
            child: SlideTransition(
                position: Tween(begin: Offset.zero, end: const Offset(-1, 0))
                    .animate(animB),
                child: child)),
        slideDownSticky => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: Offset.zero)
                .animate(animA),
            child: SlideTransition(
                position: Tween(begin: Offset.zero, end: const Offset(0, 1))
                    .animate(animB),
                child: child)),
        slideUpSticky => (ctx, animA, animB, child) => SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animA),
            child: SlideTransition(
                position: Tween(begin: Offset.zero, end: const Offset(0, -1))
                    .animate(animB),
                child: child)),
        fade => (ctx, animA, animB, child) =>
            FadeTransition(opacity: animA, child: child),
        scaleOut => (ctx, animA, animB, child) => ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.9).animate(animB),
            child: FadeTransition(opacity: animA, child: child)),
        scaleIn => (ctx, animA, animB, child) => ScaleTransition(
            scale: Tween(begin: 0.9, end: 1.0).animate(animA),
            child: FadeTransition(opacity: animA, child: child)),
        scaleUpOut => (ctx, animA, animB, child) => ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.1).animate(animB),
            child: FadeTransition(opacity: animA, child: child)),
        scaleUpIn => (ctx, animA, animB, child) => ScaleTransition(
            scale: Tween(begin: 1.1, end: 1.0).animate(animA),
            child: FadeTransition(opacity: animA, child: child)),
        rotateOut => (ctx, animA, animB, child) => RotationTransition(
            turns: Tween(begin: 0.0, end: 0.05).animate(animB),
            child: FadeTransition(
                opacity: animA,
                child: ScaleTransition(
                    scale: Tween(begin: 1.0, end: 1.30).animate(animB),
                    child: child))),
        rotateIn => (ctx, animA, animB, child) => RotationTransition(
            turns: Tween(begin: 0.05, end: 0.0).animate(animA),
            child: FadeTransition(
                opacity: animA,
                child: ScaleTransition(
                    scale: Tween(begin: 1.30, end: 1.0).animate(animA),
                    child: child))),
        rotateOutCounterClockwise => (ctx, animA, animB, child) =>
            RotationTransition(
                turns: Tween(begin: 0.0, end: -0.05).animate(animB),
                child: FadeTransition(
                    opacity: animA,
                    child: ScaleTransition(
                        scale: Tween(begin: 1.0, end: 1.30).animate(animB),
                        child: child))),
        rotateInCounterClockwise => (ctx, animA, animB, child) =>
            RotationTransition(
                turns: Tween(begin: -0.05, end: 0.0).animate(animA),
                child: FadeTransition(
                    opacity: animA,
                    child: ScaleTransition(
                        scale: Tween(begin: 1.30, end: 1.0).animate(animA),
                        child: child))),
        cubeRotateRight => (ctx, animA, animB, child) => SlideTransition(
              position: Tween(begin: const Offset(-1, 0), end: Offset.zero)
                  .animate(animA),
              child: TransformTransition(
                alignment: FractionalOffset.centerRight,
                transform: Matrix4Tween(
                        begin: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateY(pi / 2),
                        end: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateY(0))
                    .animate(animA),
                child: SlideTransition(
                  position: Tween(begin: Offset.zero, end: const Offset(1, 0))
                      .animate(animB),
                  child: TransformTransition(
                    alignment: FractionalOffset.centerLeft,
                    transform: Matrix4Tween(
                            begin: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateY(0),
                            end: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateY(-pi / 2))
                        .animate(animB),
                    child: child,
                  ),
                ),
              ),
            ),
        cubeRotateLeft => (ctx, animA, animB, child) => SlideTransition(
              position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .animate(animA),
              child: TransformTransition(
                alignment: FractionalOffset.centerLeft,
                transform: Matrix4Tween(
                        begin: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateY(-pi / 2),
                        end: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateY(0))
                    .animate(animA),
                child: SlideTransition(
                  position: Tween(begin: Offset.zero, end: const Offset(-1, 0))
                      .animate(animB),
                  child: TransformTransition(
                    alignment: FractionalOffset.centerRight,
                    transform: Matrix4Tween(
                            begin: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateY(0),
                            end: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateY(pi / 2))
                        .animate(animB),
                    child: child,
                  ),
                ),
              ),
            ),
        cubeRotateUp => (ctx, animA, animB, child) => SlideTransition(
              position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                  .animate(animA),
              child: TransformTransition(
                alignment: FractionalOffset.topCenter,
                transform: Matrix4Tween(
                        begin: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateX(-pi / 2),
                        end: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateX(0))
                    .animate(animA),
                child: SlideTransition(
                  position: Tween(begin: Offset.zero, end: const Offset(0, -1))
                      .animate(animB),
                  child: TransformTransition(
                    alignment: FractionalOffset.bottomCenter,
                    transform: Matrix4Tween(
                            begin: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(0),
                            end: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(pi / 2))
                        .animate(animB),
                    child: child,
                  ),
                ),
              ),
            ),
        cubeRotateDown => (ctx, animA, animB, child) => SlideTransition(
              position: Tween(begin: const Offset(0, -1), end: Offset.zero)
                  .animate(animA),
              child: TransformTransition(
                alignment: FractionalOffset.bottomCenter,
                transform: Matrix4Tween(
                        begin: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateX(pi / 2),
                        end: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateX(0))
                    .animate(animA),
                child: SlideTransition(
                  position: Tween(begin: Offset.zero, end: const Offset(0, 1))
                      .animate(animB),
                  child: TransformTransition(
                    alignment: FractionalOffset.topCenter,
                    transform: Matrix4Tween(
                            begin: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(0),
                            end: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(-pi / 2))
                        .animate(animB),
                    child: child,
                  ),
                ),
              ),
            ),
        flipIn => (ctx, animA, animB, child) => TransformTransition(
              alignment: FractionalOffset.center,
              transform: Matrix4Tween(
                      begin: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(pi / 2),
                      end: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(0))
                  .animate(animA),
              child: child,
            ),
        flipInY => (ctx, animA, animB, child) => TransformTransition(
              alignment: FractionalOffset.center,
              transform: Matrix4Tween(
                      begin: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateY(pi / 2),
                      end: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateY(0))
                  .animate(animA),
              child: child,
            ),
        _ => (ctx, animA, animB, child) => child,
      };
}

class TransitionedMaterialApp extends StatefulWidget {
  final MaterialAppTransitionType transitionType;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;

  const TransitionedMaterialApp({
    super.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onUnknownRoute,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
    this.title = "",
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.transitionType = MaterialAppTransitionType.slideRight,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
  });

  @override
  State<TransitionedMaterialApp> createState() =>
      _TransitionedMaterialAppState();
}

class _TransitionedMaterialAppState extends State<TransitionedMaterialApp> {
  PageRouteBuilder _generateRoute(RouteSettings settings) {
    if (widget.routes![settings.name] == null) {
      throw FlutterError('No route defined for ${settings.name}');
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, _, __) => widget.routes![settings.name]!(context),
      transitionsBuilder: widget.transitionType.transitionBuilder,
      transitionDuration: widget.transitionDuration,
      reverseTransitionDuration: widget.reverseTransitionDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: widget.key,
      navigatorKey: widget.navigatorKey,
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      onUnknownRoute: widget.onUnknownRoute,
      navigatorObservers: widget.navigatorObservers ?? const [],
      builder: widget.builder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.themeMode,
      themeAnimationDuration: widget.themeAnimationDuration,
      themeAnimationCurve: widget.themeAnimationCurve,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      onGenerateRoute: _generateRoute,
      onGenerateInitialRoutes: (initialRoute) => [
        _generateRoute(RouteSettings(name: initialRoute)),
      ],
      initialRoute: widget.initialRoute,
    );
  }
}

class TransformTransition extends StatefulWidget {
  final Animation<Matrix4>? transform;
  final Widget? child;
  final AlignmentGeometry alignment;
  const TransformTransition(
      {super.key,
      this.transform,
      this.child,
      this.alignment = Alignment.center});

  @override
  State<TransformTransition> createState() => _TransformTransitionState();
}

class _TransformTransitionState extends State<TransformTransition> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.transform!,
      builder: (context, child) {
        return Transform(
          alignment: widget.alignment,
          transform: widget.transform!.value,
          child: widget.child,
        );
      },
    );
  }
}
