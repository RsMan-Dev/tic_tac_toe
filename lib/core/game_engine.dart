import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/rounded_box.dart';
import 'package:tic_tac_toe/utils/int_extenstion.dart';
import 'package:tic_tac_toe/utils/list_extension.dart';
import 'package:tic_tac_toe/utils/matrix_4_tween_with_perspective.dart';
import 'package:tic_tac_toe/utils/sizing.dart';
import 'package:tic_tac_toe/utils/theme.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

enum Player {
  X,
  O,
  ;

  Widget get icon => FittedBox(
        fit: BoxFit.contain,
        child: switch (this) {
          Player.X => Icon(Icons.close, size: Sizing.width(300)),
          Player.O => Padding(
              padding: const EdgeInsets.all(32),
              child: Icon(
                Icons.circle_outlined,
                size: Sizing.width(300),
              ),
            ),
        },
      );
}

enum ActionDirection {
  top,
  topRight,
  right,
  bottomRight,
  bottom,
  bottomLeft,
  left,
  topLeft,
  center,
  ;

  // we want to get an instance of ActionDirectionAndForce got by index and size.
  // if index is 0 and size is 3, we want to get ActionDirectionAndForce(ActionDirection.topLeft, 1)
  // if index is 1 and size is 3, we want to get ActionDirectionAndForce(ActionDirection.top, 1)
  // if index is 7 and size is 5, we want to get ActionDirectionAndForce(ActionDirection.top, 0.5)
  // if index is 17 and size is 5, we want to get ActionDirectionAndForce(ActionDirection.bottom, 0.5)
  // if index is 24 and size is 5, we want to get ActionDirectionAndForce(ActionDirection.bottomRight, 1)
  ActionDirectionAndForce fromIndexAndSize(int index, int size) {
    var point = index.getXAndY(size);

    var forces = Point(
      point.x.xForce(size),
      point.y.yForce(size),
    );

    // [isTop, isRight, isBottom, isLeft]
    var directions = [
      forces.y < 0,
      forces.x > 0,
      forces.y > 0,
      forces.x < 0,
    ];

    var dir = fromDirections(directions);
    return ActionDirectionAndForce(
      dir,
      dir == ActionDirection.center ? 1 : max(forces.x.abs(), forces.y.abs()),
    );
  }

  ActionDirection fromDirections(List<bool> directions) {
    assert(directions.length == 4);
    if (directions[0] && directions[1]) return ActionDirection.topRight;
    if (directions[1] && directions[2]) return ActionDirection.bottomRight;
    if (directions[2] && directions[3]) return ActionDirection.bottomLeft;
    if (directions[3] && directions[0]) return ActionDirection.topLeft;
    if (directions[0]) return ActionDirection.top;
    if (directions[1]) return ActionDirection.right;
    if (directions[2]) return ActionDirection.bottom;
    if (directions[3]) return ActionDirection.left;
    return ActionDirection.center;
  }
}

class ActionDirectionAndForce {
  final ActionDirection direction;
  final double force;
  ActionDirectionAndForce(this.direction, this.force);

  Vector3? get rotation {
    return switch (direction) {
      ActionDirection.top => Vector3(-1, 0, 0),
      ActionDirection.topRight => Vector3(-1, -1, 0),
      ActionDirection.right => Vector3(0, -1, 0),
      ActionDirection.bottomRight => Vector3(1, -1, 0),
      ActionDirection.bottom => Vector3(1, 0, 0),
      ActionDirection.bottomLeft => Vector3(1, 1, 0),
      ActionDirection.left => Vector3(0, 1, 0),
      ActionDirection.topLeft => Vector3(-1, 1, 0),
      ActionDirection.center => null,
    };
  }
}

class GameData {
  final int size;
  List<Player?> grid;
  Player turn;
  bool isFinished;
  Player? winner;
  MatrixAnimationController boardTransformationController;
  AlignmentDirectional rotateDirection;
  GameData({
    this.grid = const [],
    this.turn = Player.X,
    this.isFinished = false,
    this.winner,
    required this.size,
    required this.boardTransformationController,
    this.rotateDirection = AlignmentDirectional.center,
  });
}

class MatrixAnimationController extends AnimationController {
  ActionDirectionAndForce? actionDirectionAndForce;
  MatrixAnimationController({
    required TickerProvider vsync,
    this.actionDirectionAndForce,
  }) : super(
          vsync: vsync,
          duration: const Duration(milliseconds: 600),
        );

  Matrix4 get matrix {
    var mat = Matrix4.identity();
    var rot = actionDirectionAndForce?.rotation;
    if (rot != null) mat.rotate(rot, (actionDirectionAndForce?.force ?? 1) / 4);
    mat.scale(0.95);
    return mat;
  }
}

class GameEngine extends ValueNotifier<GameData> {
  GameEngine(TickerProvider vsync, [int? size])
      : super(
          GameData(
            grid: [],
            turn: Player.X,
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
    value.turn = Player.X;
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
    value.turn = value.turn == Player.X ? Player.O : Player.X;
    animate(index);
    checkWinner();
    notifyListeners();
  }

  void checkWinner() {
    for (var p in Player.values) {
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

  Widget get render => ValueListenableBuilder(
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
                        curve: GameMatrixCurve(),
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
                    radius: Sizing.borderRadius(all: 32),
                    color: ThemeBuilder.surface,
                    padding: Sizing.edgeInsets(all: 32),
                    child: GridView.builder(
                      itemCount: value.grid.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: value.size,
                        crossAxisSpacing: Sizing.width(16),
                        mainAxisSpacing: Sizing.width(16),
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => play(index),
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
                      borderRadius: Sizing.borderRadius(all: 32),
                      color: Colors.black.withOpacity(.5),
                      child: Center(
                        child: Text(
                          "${value.winner} won!",
                          style: ThemeBuilder.h1.toBiggest.toBiggest.toSurface,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      );
}

class GameMatrixCurve extends Curve {
  @override
  double transformInternal(double t) {
    var v = 0.0;
    if (t < 0.25) {
      v = Curves.easeOut.transformInternal(t * 4);
    } else {
      v = Curves.easeInOut.transform(1 - ((t - 0.25) * (4 / 3)));
    }
    return v;
  }
}
