import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/pages/game.dart';
import 'package:tic_tac_toe/pages/home.dart';

enum Routes {
  home,
  game,
  ;

  // will transform the enum name into a path: auth_login => auth/login
  String get path => toString().replaceAll("_", "/");

  // will bind every route to its own widget builder
  WidgetBuilder get builder => switch (this) {
        Routes.home => (_) => const Home(),
        Routes.game => (_) => const Game(),
      };

  // will wrap the widget builder with providers, if any
  WidgetBuilder get finalBuilder => (context) {
        var child = builder(context);
        return child;
      };

  // will return a map of all routes, used by MaterialApp
  static Map<String, WidgetBuilder> get routes => {
        for (final route in Routes.values) route.path: route.finalBuilder,
      };
}
