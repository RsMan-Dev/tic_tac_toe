import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/animation_controllers/matrix_animation_controller.dart';
import 'package:tic_tac_toe/components/rounded_box.dart';
import 'package:tic_tac_toe/curves/hit_curve.dart';
import 'package:tic_tac_toe/enums/action_direction.dart';
import 'package:tic_tac_toe/enums/game_player.dart';
import 'package:tic_tac_toe/extensions/list_extension.dart';
import 'package:tic_tac_toe/extensions/sound_extension.dart';
import 'package:tic_tac_toe/utils/matrix_4_tween_with_perspective.dart';
import 'package:tic_tac_toe/utils/sizing.dart';
import 'package:tic_tac_toe/utils/theme.dart';

class GameData {
  final int size;
  List<GamePlayer?> grid;
  GamePlayer turn;
  bool isFinished;
  GamePlayer? winner;
  MatrixAnimationController boardTransformationController;
  AlignmentDirectional rotateDirection;
  GameData({
    this.grid = const [],
    this.turn = GamePlayer.X,
    this.isFinished = false,
    this.winner,
    required this.size,
    required this.boardTransformationController,
    this.rotateDirection = AlignmentDirectional.center,
  });
}

class GameEngine extends ValueNotifier<GameData> {
  GameEngine(TickerProvider vsync, [int? size])
      : super(
          GameData(
            grid: [],
            turn: GamePlayer.X,
            isFinished: false,
            winner: null,
            size: size ?? 3,
            boardTransformationController: MatrixAnimationController(
              vsync: vsync,
            ),
          ),
        ) {
    value.grid = List.generate(
      pow(value.size, 2).toInt(),
      (index) => null,
    );
  }

  void reset() {
    value.grid = List.generate(
      pow(value.size, 2).toInt(),
      (index) => null,
    );
    value.turn = GamePlayer.X;
    value.isFinished = false;
    value.winner = null;
    value.boardTransformationController.actionDirectionAndForce = null;
    value.boardTransformationController.reset();
    notifyListeners();
  }

  void play(int index) {
    if (value.isFinished) return;
    if (value.grid[index] != null) return;
    value.grid[index] = value.turn;
    value.turn = value.turn == GamePlayer.X ? GamePlayer.O : GamePlayer.X;
    animate(index);
    checkWinner();
    notifyListeners();
  }

  void checkWinner() {
    for (var p in GamePlayer.values) {
      for (var i = 0; i < value.size; i++) {
        // check rows
        if (value.grid.everyIndexed(
          (e, id) => id ~/ value.size == i ? e == p : true,
        )) {
          value.isFinished = true;
          value.winner = p;
          return;
        }
        // check columns
        if (value.grid.everyIndexed(
          (e, id) => id % value.size == i ? e == p : true,
        )) {
          value.isFinished = true;
          value.winner = p;
          return;
        }
      }
      // check diagonals size + 1 wil make make it search from top left to bottom right
      if (value.grid.everyIndexed(
        (e, i) => i % (value.size + 1) == 0 ? e == p : true,
      )) {
        value.isFinished = true;
        value.winner = p;
        return;
      }
      // check diagonals size - 1 wil make make it search from top right to bottom left
      // (index check to avoid checking the first and last element because its on wrong diagonal,
      // they be checked without this condition because modulo is < size and start at 0)
      if (value.grid.everyIndexed(
        (e, i) =>
            i % (value.size - 1) == 0 && ![0, value.grid.length - 1].contains(i)
                ? e == p
                : true,
      )) {
        value.isFinished = true;
        value.winner = p;
        return;
      }
    }
  }

  // we want to animate the bord like a force is applied to it where the user clicked
  // so we will apply a rotate 3d matrix into the direction of the click, if it's on center
  // we will only scale down a little bit the board to keep the illusion of a force
  // if it's per example on the left, we will rotate the board -10 degrees on the y axis,
  // and scale it down a little bit
  void animate(int index) {
    value.boardTransformationController.actionDirectionAndForce =
        ActionDirection.center.fromIndexAndSize(index, value.size);
    value.boardTransformationController.reset();
    value.boardTransformationController.animateTo(1).then((_) {
      value.boardTransformationController.reset();
    });
  }

  Widget render(BuildContext context) => Column(
        children: [
          Text("Tour du ${value.turn.name}",
              style: Theme.of(context).textTheme.displayMedium),
          Sizing.verticalSpacer(16),
          ValueListenableBuilder(
            valueListenable: this,
            builder: (context, value, child) {
              return AnimatedBuilder(
                animation: value.boardTransformationController,
                builder: (context, child) {
                  return Transform(
                    alignment: AlignmentDirectional.center,
                    transform: Matrix4TweenWithPerspective(
                      begin: Matrix4.identity(),
                      end: value.boardTransformationController.matrix,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: value.boardTransformationController,
                            curve: HitCurve(),
                          ),
                        )
                        .value,
                    child: child,
                  );
                },
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: RoundedBox(
                        radius: Sizing.borderRadius(all: 16),
                        color: ThemeBuilder.surface,
                        padding: Sizing.edgeInsets(all: 16),
                        child: GridView.builder(
                          itemCount: value.grid.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: value.size,
                            crossAxisSpacing: Sizing.width(12),
                            mainAxisSpacing: Sizing.width(12),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.playSound(SoundEffects.impact);
                                play(index);
                              },
                              child: RoundedBox(
                                color: ThemeBuilder.background,
                                radius: Sizing.borderRadius(all: 16),
                                child: Center(
                                  child: value.grid[index]?.icon,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (value.winner != null)
                      Positioned.fill(
                        child: Material(
                          borderRadius: Sizing.borderRadius(all: 16),
                          color: Colors.black.withOpacity(.5),
                          child: Center(
                            child: Text(
                              value.winner!.victoryMessage,
                              style:
                                  ThemeBuilder.h1.toBiggest.toBiggest.toSurface,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      );
}
