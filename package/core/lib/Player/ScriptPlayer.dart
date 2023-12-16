import 'dart:async';

import 'package:package_beatfighter/Player/CustomStopwatch.dart';
import 'package:package_beatfighter/Script/ScriptManager.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

enum ScriptPlayerState {
  Play,
  Pause,
  Stop,
  Complete,
}

class ScriptPlayer {
  void dispose() {
    if (playerTimer.isActive) playerTimer.cancel();
  }

  late CustomStopwatch stopwatchTimer = CustomStopwatch.with_UpdateFunction(function: update);
  ScriptPlayerState _playerState = ScriptPlayerState.Stop;
  late Timer playerTimer;
  int skipTime = 5000;
  bool _needInit = false;
  late int? nextNoteKey;

  ScriptPlayerState get_PlayerState() => _playerState;

  bool get isRun {return ScriptPlayerState.Play == get_PlayerState();}

  bool set_Play() {
    if (get_PlayerState() != ScriptPlayerState.Play) {
      _playerState = ScriptPlayerState.Play;
      stopwatchTimer.start();
      nextNoteKey = find_NextNoteKey();
      return true;
    }
    return false;
  }

  bool set_Pause() {
    if (get_PlayerState() == ScriptPlayerState.Play) {
      _playerState = ScriptPlayerState.Pause;
      stopwatchTimer.pause();
      // bgm pause
      return true;
    }
    return false;
  }

  void set_Stop() {
    stopwatchTimer.stop();
    AllNoteInit();
    _playerState = ScriptPlayerState.Stop;
  }

  void set_Complete() {
    _playerState = ScriptPlayerState.Complete;
    stopwatchTimer.pause();
    stopwatchTimer.jump(Duration(milliseconds: BFCore().seletedScript.get_ScriptLength()));
  }

  void rewind({int? time}) {
    // need check zero
    _needInit = true;
    if (time == null) {
      stopwatchTimer.rewind(Duration(milliseconds: skipTime));
    } else {
      stopwatchTimer.rewind(Duration(milliseconds: time));
    }
  }

  void forward({int? time}) {
    // need check complete
    _needInit = true;
    if (time == null) {
      stopwatchTimer.forward(Duration(milliseconds: skipTime));
    } else {
      stopwatchTimer.forward(Duration(milliseconds: time));
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

  void update() {
    initCheck_Script();
    switch (_playerState) {
      case ScriptPlayerState.Play:
        {
          var script = BFCore().seletedScript;
          if (script.get_ScriptLength() < stopwatchTimer.get_NowTimeinMilliseconds()) {
            set_Complete();
          } else {
            // check NestNote
            if (nextNoteKey == null) {
              nextNoteKey = find_NextNoteKey();
            }

            // Time Check with NextNote
            if (nextNoteKey != null) {
              if (nextNoteKey! <= stopwatchTimer.get_NowTimeinMilliseconds()) {
                var note = script.get_NoteFromSec(nextNoteKey!);
                note!.play_Note();
                nextNoteKey = find_NextNoteKey();
              }
            }
          }
        }
        break;
      case ScriptPlayerState.Pause:
        {}
        break;
      case ScriptPlayerState.Stop:
        {}
        break;
      case ScriptPlayerState.Complete:
        {}
        break;
    }
  }

  void initCheck_Script() {
    if (_needInit) {
      _needInit = false;

      // time & set next Script
      nextNoteKey = find_NextNoteKey();

      var mapNote = BFCore().seletedScript.get_SortedNote();
      mapNote.forEach((key, value) {
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
          result ??= element;
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
    if (_SkipTime > 0) skipTime = _SkipTime;
  }
}
