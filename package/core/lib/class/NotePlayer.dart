import 'dart:async';

import 'package:package_beatfighter/class/CustomStopwatch.dart';

enum NotePlayerState {
  Play,
  Pause,
  Stop,
  Complete,
}

class NotePlayer {
  NotePlayerState _state = NotePlayerState.Stop;

  CustomStopwatch timer = CustomStopwatch();
  int skiptime = 5000;

  NotePlayerState get_PlayerState() => _state;
  void set_PlayerState(NotePlayerState _State) => _state = _State;

  int Timertime() => timer.elapsedTime.inMilliseconds;
  int get_PlayTime_milliesec() => timer.elapsedTime.inMilliseconds % 1000;

  int get_PlayTime_sec() => (Timertime() ~/ 1000) % 60;

  int get_PlayTime_minutes() => (Timertime() ~/ (1000 * 60)) % 60;

  String get_PlayTimeString_milliesec() => get_PlayTime_milliesec().toString().padLeft(3, '0');

  String get_PlayTimeString_sec() => get_PlayTime_sec().toString().padLeft(2, '0');

  String get_PlayTimeString_minutes() => get_PlayTime_minutes().toString().padLeft(2, '0');

  String get_PlayTime_inFormat() => TimeFormat(Timertime());

  String TimeFormat(int time) {
    final int milliseconds = time % 1000;
    final int seconds = (time ~/ 1000) % 60;
    final int minutes = (time ~/ (1000 * 60)) % 60;

    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = seconds.toString().padLeft(2, '0');
    final String millisecondsStr = milliseconds.toString().padLeft(3, '0');

    return '$minutesStr:$secondsStr.$millisecondsStr';
  }

  void startTimer() {
    timer.start();
  }

  void resetTimer() {
    timer.reset();
  }

  void pauseTimer() {
    timer.pause();
  }

  void rewindTimer() {
    timer.rewind(Duration(milliseconds: skiptime));
  }

  void forwardTimer() {
    timer.forward(Duration(milliseconds: skiptime));
  }

  void changeSkipTime(int _SkipTime) {
    if (_SkipTime > 0) skiptime = _SkipTime;
  }
}
