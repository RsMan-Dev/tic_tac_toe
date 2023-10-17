import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/rounded_box.dart';
import 'package:tic_tac_toe/utils/bp_extensions.dart';
import 'package:tic_tac_toe/utils/sizing.dart';
import 'package:tic_tac_toe/utils/theme.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: min(
              width /
                  bp(
                    xs: 1.1,
                    sm: 1.25,
                    md: 1.5,
                    lg: 2,
                    xl: 3,
                  ),
              height / 1.2),
          child: AspectRatio(
            aspectRatio: 1,
            child: RoundedBox(
              radius: Sizing.borderRadius(all: 32),
              color: ThemeBuilder.surface,
              padding: Sizing.edgeInsets(all: 32),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizing.width(16),
                  mainAxisSpacing: Sizing.width(16),
                ),
                children: List.generate(
                  9,
                  (index) => RoundedBox(
                    color: ThemeBuilder.background,
                    radius: Sizing.borderRadius(all: 16),
                    child: Center(
                      child: Text(
                        index.toString(),
                        style: ThemeBuilder.h1.toBiggest,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
