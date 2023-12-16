import 'dart:async';

import 'package:package_beatfighter/Player/ScriptPlayer.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

class CustomStopwatch {
  void dispose() {
    if (_timer.isActive) _timer.cancel();
  }

  late Timer _timer;
  DateTime? _previousTime;
  double _speed = 1.0;
  Duration _elapsedTime = Duration.zero;

  Duration get elapsedTime => _elapsedTime;

  int get_NowTimeinMilliseconds() => _elapsedTime.inMilliseconds;

  double get speed => _speed;

  set speed(double value) {
    if (value > 0) _speed = value;
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

  void rewind(Duration duration) {
    if (elapsedTime - duration < Duration.zero) {
      _elapsedTime = Duration.zero;
    } else {
      _elapsedTime -= duration;
    }
  }

  void forward(Duration duration) {
    _elapsedTime += duration;
  }

  void jump(Duration duration) {
    if (duration < Duration.zero) {
      _elapsedTime = Duration.zero;
    } else {
      _elapsedTime = duration;
    }
  }

  void _updateTime() {
    final now = DateTime.now();
    final frameTime = now.difference(_previousTime!);
    _elapsedTime += frameTime * _speed; // 수정된 부분
    _previousTime = now;
  }
}
