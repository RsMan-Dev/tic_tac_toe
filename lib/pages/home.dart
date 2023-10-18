import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/chance_button.dart';
import 'package:tic_tac_toe/routes.dart';
import 'package:tic_tac_toe/utils/sizing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  gotoGame() => Navigator.of(context).pushNamed(Routes.game.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue dans le super",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              "Tic Tac Toe!!",
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...{
                    "Jouer": 1.0,
                    "Jouer probablement": 0.75,
                    "Jouer peut être": 0.5,
                    "Jouer peut être pas": 0.25,
                    "Ne pas jouer": 0.0,
                  }
                      .entries
                      .map(
                        (e) => [
                          Sizing.verticalSpacer(24),
                          ChanceButton(
                            chance: e.value,
                            onPressed: gotoGame,
                            child: Text(e.key),
                          )
                        ],
                      )
                      .toList()
                      .flattened,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
