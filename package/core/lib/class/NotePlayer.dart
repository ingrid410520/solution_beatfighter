import 'dart:async';

import 'package:package_beatfighter/class/CustomStopwatch.dart';
import 'package:package_beatfighter/class/NoteScript.dart';

int _initScriptLength = 5000;

enum NotePlayerState {
  Play,
  Pause,
  Stop,
  Complete,
}

class NotePlayer {
  NotePlayerState _state = NotePlayerState.Stop;
  Map<int, NoteScript> mapNoteScript = Map<int, NoteScript>();
  int _noteScriptLength = _initScriptLength;
  CustomStopwatch timer = CustomStopwatch();
  int skiptime = 5000;

  NotePlayerState get_PlayerState() => _state;

  void set_PlayerState(NotePlayerState _State) => _state = _State;

  int get_NoteScriptLength() => _noteScriptLength;

  void set_NoteScriptLength(int length) {
    if (length > 0) _noteScriptLength = length;
  }

  int get_PlayTime() => timer.elapsedTime.inMilliseconds;

  int get_PlayTime_milliesec() => timer.elapsedTime.inMilliseconds % 1000;

  int get_PlayTime_sec() => (get_PlayTime() ~/ 1000) % 60;

  int get_PlayTime_minutes() => (get_PlayTime() ~/ (1000 * 60)) % 60;

  String get_PlayTimeString_milliesec() => get_PlayTime_milliesec().toString().padLeft(3, '0');

  String get_PlayTimeString_sec() => get_PlayTime_sec().toString().padLeft(2, '0');

  String get_PlayTimeString_minutes() => get_PlayTime_minutes().toString().padLeft(2, '0');

  String get_PlayTime_inFormat() => TimeFormat(get_PlayTime());

  String TimeFormat(int time) {
    final int milliseconds = time % 1000;
    final int seconds = (time ~/ 1000) % 60;
    final int minutes = (time ~/ (1000 * 60)) % 60;

    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = seconds.toString().padLeft(2, '0');
    final String millisecondsStr = milliseconds.toString().padLeft(3, '0');

    return '$minutesStr:$secondsStr.$millisecondsStr';
  }

  Map get_NoteScript() {
    var sortedByKeyMap = Map.fromEntries(mapNoteScript.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    return sortedByKeyMap;
  }

  NoteScript get_NoteScriptFromIndex(int index) {
    var sortedByKeyMap = Map.fromEntries(mapNoteScript.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    var key = sortedByKeyMap.keys.toList()[index];
    var value = get_NoteScriptFromSec(key)!;

    return value;
  }

  NoteScript? get_NoteScriptFromSec(int sec) {
    if (mapNoteScript.containsKey(sec)) return mapNoteScript[sec];
  }

  void insertNoteScript(NoteScript script) {
    if (mapNoteScript.containsKey(script.sec)) {
      NoteScript before = mapNoteScript[script.sec]!;
      before.addScript(script);
    } else {
      mapNoteScript[script.sec] = script;
    }
  }

  void modifyNoteScript() {}

  void deleteNoteScript(int sec) {
    mapNoteScript.remove(sec);
  }

  void startTimer() {
    if (get_PlayerState() != NotePlayerState.Play) {
      set_PlayerState(NotePlayerState.Play);
      timer.start();
    }
  }

  void stopTimer() {
    set_PlayerState(NotePlayerState.Stop);
    timer.stop();
  }

  void pauseTimer() {
    set_PlayerState(NotePlayerState.Pause);
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
