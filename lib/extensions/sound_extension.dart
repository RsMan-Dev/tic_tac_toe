import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum SoundEffects {
  error("error.mp3",
      startAt: Duration(milliseconds: 620), speed: 1.5, volume: 0.8),
  impact("impact.mp3"),
  start("start.mp3", startAt: Duration(milliseconds: 100), speed: 1.5),
  ;

  final String _path;
  final Duration startAt;
  final double speed;
  final double volume;
  const SoundEffects(this._path,
      {this.startAt = Duration.zero, this.speed = 1, this.volume = 1});

  String get path => "sound_effects/$_path";
}

extension SoundExtension on BuildContext {
  static late final Map<SoundEffects, AudioPlayer> _players;

  // wants to cache the players, to avoid play delay, some delay
  // is still there, but it is not that much
  Future<void> initSounds() async {
    _players = {
      for (var effect in SoundEffects.values)
        effect: AudioPlayer(playerId: effect.toString())
          ..setSourceAsset(effect.path)
    };
  }

  Future<void> disposeSounds() async {
    for (var player in _players.values) {
      await player.dispose();
    }
  }

  Future<void> playSound(SoundEffects effect) async {
    final player = SoundExtension._players[effect]!;
    await player.seek(effect.startAt);
    await player.setPlaybackRate(effect.speed);
    await player.setVolume(effect.volume);
    await player.resume();
  }
}

extension SoundExtensionState on State {
  Future<void> playSound(SoundEffects effect) async {
    await context.playSound(effect);
  }
}
