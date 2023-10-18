import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/game_engine.dart';
import 'package:tic_tac_toe/extensions/bp_extension.dart';
import 'package:tic_tac_toe/utils/sizing.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late final GameEngine engine = GameEngine(this);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    width = min(
        width /
            bp(
              xs: 1.1,
              sm: 1.25,
              md: 1.5,
              lg: 2,
              xl: 3,
            ),
        (height / 1.2) - Sizing.width(64));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Sizing.verticalSpacer(16),
            SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Retour à l'accueil"),
                  ),
                  ElevatedButton(
                    onPressed: () => engine.reset(),
                    child: const Text("Réinitialiser"),
                  ),
                ],
              ),
            ),
            Sizing.verticalSpacer(16),
            SizedBox(
              width: width,
              child: engine.render(context),
            ),
          ],
        ),
      ),
    );
  }
}
