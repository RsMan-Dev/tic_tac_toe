import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/curves/shake_curve.dart';
import 'package:tic_tac_toe/extensions/sound_extension.dart';

// wants a button with chance provided who executes action with that chance
// will shake if loose, will execute action if win
class ChanceButton extends StatefulWidget {
  final Function onPressed;
  final double chance;
  final Widget child;

  const ChanceButton({
    super.key,
    required this.onPressed,
    required this.chance,
    required this.child,
  });

  @override
  State<ChanceButton> createState() => _ChanceButtonState();
}

class _ChanceButtonState extends State<ChanceButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

  press() {
    if (Random().nextDouble() < widget.chance) {
      playSound(SoundEffects.start);
      widget.onPressed();
    } else {
      playSound(SoundEffects.error);
      controller.reset();
      controller.animateTo(1).then((_) =>
          // flutter's animation controller don't calculate the last frame using his
          // curve, it just render like curve returned 1, but mine returns 0 at t=1
          // so instead using forward, we will just reset the animation controller
          // before and after the animation
          controller.reset());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(20, 0),
        )
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: const ShakeCurve(),
              ),
            )
            .value,
        child: child,
      ),
      child: FilledButton(
        onPressed: press,
        child: widget.child,
      ),
    );
  }
}
