import 'dart:async';

import 'package:package_beatfighter/Player/CustomStopwatch.dart';
import 'package:package_beatfighter/Script/Note.dart';
import 'package:package_beatfighter/Script/ScriptManager.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

enum ScriptPlayerState {
  Play,
  Pause,
  Stop,
  Complete,
}

class ScriptPlayer {
  ScriptPlayer() {
    playerTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _update();
    });
  }

  void dispose() {
    if (playerTimer.isActive) playerTimer.cancel();
  }

  CustomStopwatch stopwatchTimer = CustomStopwatch();
  ScriptPlayerState _state = ScriptPlayerState.Stop;
  late Timer playerTimer;

  int skiptime = 5000;
  bool _needInit = false;
  late int? nextScriptKey;

  ScriptPlayerState get_PlayerState() => _state;

  void set_PlayerState(ScriptPlayerState _State) => _state = _State;

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

  void _update() {
    initCheckScript();

    switch (_state) {
      case ScriptPlayerState.Play:
        {
          if (BFCore().seletedScript.get_ScriptLength() < stopwatchTimer.get_NowTimeinMilliseconds()) {
            stopwatchTimer.pause();
            stopwatchTimer.jump(Duration(milliseconds: BFCore().seletedScript.get_ScriptLength()));
            _state = ScriptPlayerState.Complete;
          } else {
            // script check and excute
          }
        }
        break;

      case ScriptPlayerState.Pause:
        {
          //bgm stop
        }
        break;

      case ScriptPlayerState.Stop:
        {
          AllNoteInit();
        }
        break;

      case ScriptPlayerState.Complete:
        {}
        break;
    }
  }

  void startTimer() {
    if (get_PlayerState() != ScriptPlayerState.Play) {
      set_PlayerState(ScriptPlayerState.Play);
      stopwatchTimer.start();
    }
  }

  void stopTimer() {
    set_PlayerState(ScriptPlayerState.Stop);
    stopwatchTimer.stop();
    AllNoteInit();
  }

  void pauseTimer() {
    set_PlayerState(ScriptPlayerState.Pause);
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
      nextScriptKey = find_NextNoteKey();

      var mapScript = ScriptManager().get_SelectScript()!.get_SortedNote();
      mapScript.forEach((key, value) {
        if (key < stopwatchTimer.get_NowTimeinMilliseconds()) {
          value.init_PlayDone();
        } else {
          value.set_PlayDone(true);
        }
      });
    }
  }

  int? find_NextNoteKey() {
    var result = null;
    var mapScript = ScriptManager().get_SelectScript()!.get_SortedNote();
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

  void AllNoteInit() {
    var mapScript = ScriptManager().get_SelectScript()!.get_SortedNote();
    mapScript.forEach((key, value) => value.init_PlayDone());
  }

  void changeSkipTime(int _SkipTime) {
    if (_SkipTime > 0) skiptime = _SkipTime;
  }
}
