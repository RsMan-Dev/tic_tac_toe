import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum SoundEffects {
  error("error.mp3", startAt: Duration(milliseconds: 620)),
  impact("impact.mp3"),
  start("start.mp3", startAt: Duration(milliseconds: 100)),
  ;

  final String _path;
  final Duration? startAt;
  const SoundEffects(this._path, {this.startAt});

  String get path => "sound_effects/$_path";
}

extension SoundExtension on BuildContext {
  static final player = AudioPlayer();

  Future<void> playSound(SoundEffects effect) async {
    await player.play(AssetSource(effect.path));
    player.seek(effect.startAt ?? Duration.zero);
  }
}

extension SoundExtensionState on State {
  Future<void> playSound(SoundEffects effect) async {
    await context.playSound(effect);
  }
}
