import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/sizing.dart';

enum GamePlayer {
  X,
  O,
  ;

  Widget get icon => FittedBox(
        fit: BoxFit.contain,
        child: switch (this) {
          GamePlayer.X => Icon(Icons.close, size: Sizing.width(300)),
          GamePlayer.O => Padding(
              padding: const EdgeInsets.all(32),
              child: Icon(
                Icons.circle_outlined,
                size: Sizing.width(300),
              ),
            ),
        },
      );

  String get name => switch (this) {
        GamePlayer.X => "Joueur X",
        GamePlayer.O => "Joueur O",
      };

  String get victoryMessage => switch (this) {
        GamePlayer.X => "Joueur X a gagné!",
        GamePlayer.O => "Joueur O a gagné!",
      };
}
