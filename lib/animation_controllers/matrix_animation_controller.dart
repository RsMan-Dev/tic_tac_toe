import 'package:flutter/material.dart';
import 'package:tic_tac_toe/enums/action_direction.dart';

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
