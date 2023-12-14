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
  NotePlayer() {
    playerTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _update();
    });
  }

  void dispose() {
    if (playerTimer.isActive) playerTimer.cancel();
  }

  NotePlayerState _state = NotePlayerState.Stop;
  late Timer playerTimer;
  Map<int, NoteScript> mapNoteScript = Map<int, NoteScript>();
  int _noteScriptLength = _initScriptLength;
  CustomStopwatch stopwatchTimer = CustomStopwatch(Duration(milliseconds: _initScriptLength));
  int skiptime = 5000;
  bool _needInit = false;
  late int? nextScriptKey;

  NotePlayerState get_PlayerState() => _state;

  void set_PlayerState(NotePlayerState _State) => _state = _State;

  int get_NoteScriptLength() => _noteScriptLength;

  void set_NoteScriptLength(int length) {
    if (length > 0) {
      _noteScriptLength = length;
      stopwatchTimer.set_MaxTime(Duration(milliseconds: _noteScriptLength));
    }
    ;
  }

  void _update() {
    initCheckScript();

    switch (_state) {
      case NotePlayerState.Play:
        {
          // script check and excute
        }
        break;

      case NotePlayerState.Pause:
        {
          //bgm stop
        }
        break;

      case NotePlayerState.Stop:
        {
          AllScriptInit();
        }
        break;

      case NotePlayerState.Complete:
        {}
        break;
    }
  }

  int get_PlayTime() => stopwatchTimer.elapsedTime.inMilliseconds;

  int get_PlayTime_milliesec() => stopwatchTimer.elapsedTime.inMilliseconds % 1000;

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

  Map<int, NoteScript> get_NoteScript() {
    var sortedByKeyMap = Map.fromEntries(mapNoteScript.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    return sortedByKeyMap;
  }

  NoteScript get_NoteScriptFromIndex(int index) {
    var sortedByKeyMap = Map.fromEntries(mapNoteScript.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    var key = sortedByKeyMap.keys.toList()[index];
    var value = get_NoteScriptFromSec(key)!;

    return value;
  }

  bool check_NoteScriptFromSec(int sec) => mapNoteScript.containsKey(sec);

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
      stopwatchTimer.start();
    }
  }

  void stopTimer() {
    set_PlayerState(NotePlayerState.Stop);
    stopwatchTimer.stop();
    AllScriptInit();
  }

  void pauseTimer() {
    set_PlayerState(NotePlayerState.Pause);
    stopwatchTimer.pause();
  }

  void rewindTimer() {
    _needInit = true;
    stopwatchTimer.rewind(Duration(milliseconds: skiptime));
  }

  void forwardTimer() {
    _needInit = true;
    stopwatchTimer.forward(Duration(milliseconds: skiptime));
  }

  void initCheckScript() {
    if (_needInit) {
      _needInit = false;

      // time & set next Script
      nextScriptKey = find_NextScriptKey();

      var mapScript = get_NoteScript();
      mapScript.forEach((key, value) {
        if (key < stopwatchTimer.get_NowTimeinMilliseconds()) {
          value.setPlayDoneInit();
        } else {
          value.setPlayDone(true);
        }
      });
    }
  }

  int? find_NextScriptKey() {
    var result = null;
    var mapScript = get_NoteScript();
    var listKeys = mapScript.keys.toList();

    if (listKeys.isNotEmpty) {
      listKeys.forEach((element) {
        if (stopwatchTimer.get_NowTimeinMilliseconds() < element) {
          result = element;
        }
      });
    }

    return result;
  }

  void AllScriptInit() {
    var mapScript = get_NoteScript();
    mapScript.forEach((key, value) => value.setPlayDoneInit());
  }

  void changeSkipTime(int _SkipTime) {
    if (_SkipTime > 0) skiptime = _SkipTime;
  }
}
