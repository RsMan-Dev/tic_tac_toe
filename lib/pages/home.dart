import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/routes.dart';
import 'package:tic_tac_toe/utils/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  gotoGame(double chance) {
    if (Random().nextDouble() < chance) {
      Navigator.of(context).pushNamed(Routes.game.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Bienvenue dans le super Tic Tac Toe!!",
              style: ThemeBuilder.h1,
              textAlign: TextAlign.center,
            ),
            ...{
              "Jouer": () => gotoGame(1),
              "Jouer probablement": () => gotoGame(0.75),
              "Jouer peut être": () => gotoGame(0.5),
              "Jouer peut être pas": () => gotoGame(0.25),
              "Ne pas jouer": () => gotoGame(0),
            }
                .entries
                .map((e) => FilledButton(
                      onPressed: e.value,
                      child: Text(e.key),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
