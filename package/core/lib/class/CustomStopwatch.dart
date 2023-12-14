import 'dart:async';

import 'package:package_beatfighter/class/NotePlayer.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

class CustomStopwatch {
  CustomStopwatch(Duration MaxTime) : _MaxTime = MaxTime;

  void dispose() {
    if (_timer.isActive) _timer.cancel();
  }

  late Timer _timer;
  DateTime? _previousTime;
  double _speed = 1.0;
  Duration _elapsedTime = Duration.zero;
  Duration _MaxTime;

  Duration get elapsedTime => _elapsedTime;

  int get_NowTimeinMilliseconds() => _elapsedTime.inMilliseconds;

  Duration get_MaxTime() => _MaxTime;

  double get speed => _speed;

  void set_MaxTime(Duration time) {
    _MaxTime = time;
  }

  set speed(double value) {
    if (value > 0) {
      _speed = value;
    }
  }

  void start() {
    _previousTime = DateTime.now();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _updateTime();
    });
  }

  void pause() {
    _timer.cancel();
  }

  void stop() {
    _timer.cancel();
    _elapsedTime = Duration.zero;
  }

  void complete() {
    BFCore().notePlayer.set_PlayerState(NotePlayerState.Complete);
    _timer.cancel();
    _elapsedTime = _MaxTime;
  }

  void rewind(Duration duration) {
    if (elapsedTime - duration >= Duration.zero) {
      _elapsedTime -= duration;
    } else {
      stop();
    }
  }

  void forward(Duration duration) {
    if (elapsedTime.inMilliseconds + duration.inMilliseconds >= _MaxTime.inMilliseconds) {
      complete();
    } else {
      _elapsedTime += duration;
    }
  }

  void jump(Duration duration) {}

  void _updateTime() {
    final now = DateTime.now();
    final frameTime = now.difference(_previousTime!);
    _elapsedTime += frameTime * _speed; // 수정된 부분
    _previousTime = now;

    if (_MaxTime.inMilliseconds <= _elapsedTime.inMilliseconds) {
      complete();
    }
  }
}
