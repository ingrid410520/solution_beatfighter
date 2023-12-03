import 'dart:async';

import 'package:package_beatfighter/class/NotePlayer.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

class CustomStopwatch {
  late Timer timer;
  DateTime? _previousTime;
  double _speed = 1.0;
  Duration _elapsedTime = Duration.zero;

  Duration get elapsedTime => _elapsedTime;

  double get speed => _speed;

  set speed(double value) {
    if (value > 0) {
      _speed = value;
    }
  }

  void start() {
    _previousTime = DateTime.now();
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _updateTime();
    });
  }

  void pause() {
    timer.cancel();
  }

  void stop() {
    timer.cancel();
    _elapsedTime = Duration.zero;
  }

  void complete() {
    BFCore().notePlayer.set_PlayerState(NotePlayerState.Complete);
    timer.cancel();
    _elapsedTime = Duration(milliseconds: BFCore().notePlayer.get_NoteScriptLength());
  }

  void rewind(Duration duration) {
    if (elapsedTime - duration >= Duration.zero) {
      _elapsedTime -= duration;
    } else {
      stop();
    }
  }

  void forward(Duration duration) {
    if (elapsedTime.inMilliseconds + duration.inMilliseconds >= BFCore().notePlayer.get_NoteScriptLength()) {
      complete();
    } else {
      _elapsedTime += duration;
    }
  }

  void _updateTime() {
    final now = DateTime.now();
    final frameTime = now.difference(_previousTime!);
    _elapsedTime += frameTime * _speed; // 수정된 부분
    _previousTime = now;

    if (BFCore().notePlayer.get_NoteScriptLength() <= BFCore().notePlayer.get_PlayTime()) {
      complete();
    }
  }
}
