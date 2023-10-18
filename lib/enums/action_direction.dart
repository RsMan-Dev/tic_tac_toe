import 'dart:math';

import 'package:tic_tac_toe/extensions/int_extenstion.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

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
