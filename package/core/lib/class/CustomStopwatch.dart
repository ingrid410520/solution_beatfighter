import 'dart:async';

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

  void reset() {
    _elapsedTime = Duration.zero;
  }

  void rewind(Duration duration) {
    if (elapsedTime - duration >= Duration.zero) {
      _elapsedTime -= duration;
    } else {
      reset();
    }
  }

  void forward(Duration duration) {
    _elapsedTime += duration;
  }

  void _updateTime() {
    final now = DateTime.now();
    final frameTime = now.difference(_previousTime!);
    _elapsedTime += frameTime * _speed; // 수정된 부분
    _previousTime = now;
  }
}
