import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:tic_tac_toe/components/transitioned_material_app.dart';
import 'package:tic_tac_toe/routes.dart';
import 'package:tic_tac_toe/utils/sizing.dart';
import 'package:tic_tac_toe/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Sizing.init(context, 1440, 900);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Layout(
        child: Builder(builder: (context) {
          return TransitionedMaterialApp(
            locale: const Locale('fr', 'FR'),
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            title: 'Billetterie Guichet',
            debugShowCheckedModeBanner: false,
            theme: ThemeBuilder.theme,
            routes: Routes.routes,
            initialRoute: Routes.home.path,
            transitionType: MaterialAppTransitionType.fade,
            transitionDuration: const Duration(milliseconds: 150),
            reverseTransitionDuration: const Duration(milliseconds: 150),
          );
        }),
      ),
    );
  }
}
