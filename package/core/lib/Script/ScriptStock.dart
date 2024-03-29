import 'package:package_beatfighter/Script/Note.dart';

int _initScriptLength = 5000;

class ScriptStock {
  ScriptStock({required String scriptName, required int length})
      : _scriptName = scriptName,
        _scriptLength = length {}
  String _scriptName;
  int _scriptLength = _initScriptLength;
  Map<int, Note> mapNote = Map<int, Note>();

  Map<String, dynamic> toJson() {
    return {
      '_scriptName': _scriptName,
      '_scriptLength': _scriptLength,
      'mapNote': mapNote.map((key, value) => MapEntry(key.toString(), value.toJson())),
    };
  }

  fromJson(Map mapNote){
    //print(mapNote);
    mapNote.forEach((key, value) {
      int time = int.parse(key);
      print("noteTime $key : ");
      print(value);
      print(value['_sec']);
      print(value['NoteInfo']);
      NoteInfo info= NoteInfo();
      info.fromJson(value['NoteInfo']);

      insert_Note(time, info);
    });
  }

  String get_ScriptName() => _scriptName;

  void change_ScriptName(String scriptName) {
    _scriptName = scriptName;
  }

  int get_ScriptLength() => _scriptLength;

  void set_ScriptLength(int length) {
    if (length > 0) _scriptLength = length;
  }

  Map<int, Note> get_SortedNote() {
    var sortedByKeyMap = Map.fromEntries(mapNote.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    return sortedByKeyMap;
  }

  bool insert_Note(int sec, NoteInfo info) {
    if (check_NoteFromSec(sec)) {
      return false;
    } else {
      Note inst = Note(sec: sec, noteInfo: info);
      mapNote[sec] = inst;
      return true;
    }
  }

  void reset_Note(){
    mapNote.clear();
  }

  void modify_Note(int sec, NoteInfo info) {
    if (check_NoteFromSec(sec)) {
      mapNote[sec]!.cover_NoteInfo(info);
    } else {
      mapNote[sec] = Note(sec: sec, noteInfo: info);
    }
  }

  bool delete_Note(int sec) {
    if (check_NoteFromSec(sec)) {
      mapNote.remove(sec);
      return true;
    } else {
      return false;
    }
  }

  String get_ScriptInfo() {
    String result = "${get_ScriptName()}(${get_ScriptLength()})\n";


    if (get_SortedNote().isEmpty) {
      result += "Empty\n";
    } else {
      get_SortedNote().forEach((key, value) {
        var noteSec = key;
        var bgm = value.noteInfo.bgm ?? " - ";
        var noteA = value.noteInfo.noteA ? "O" : "-";
        var noteB = value.noteInfo.noteB ? "O" : "-";
        var eventCount = value.noteInfo.listEvent.length;
        var subtitleCount = value.noteInfo.listSubTitle.length;
        result += "$noteSec) : bgm:$bgm \t/ A:$noteA \tB:$noteB \t/ Event:$eventCount \tSubtitle:$subtitleCount\n";
      });
    }

    return result;
  }

  bool isEmpty_NoteInfo() {
    clear_EmptyNote();
    return mapNote.isEmpty;
  }

  void clear_EmptyNote() {}

  void reverse_NoteA(int sec) {
    if (check_NoteFromSec(sec)) {
      bool value = get_NoteFromSec(sec)!.get_NoteInfo().noteA;
      mapNote[sec]!.cover_NoteInfo(NoteInfo(noteA: !value));
      //get_NoteFromSec(sec)!.cover_NoteInfo(NoteInfo(noteA: !value));
    } else {
      mapNote[sec] = Note(sec: sec, noteInfo: NoteInfo(noteA: true));
    }
  }

  void reverse_NoteB(int sec) {
    if (check_NoteFromSec(sec)) {
      bool value = get_NoteFromSec(sec)!.get_NoteInfo().noteB;
      mapNote[sec]!.cover_NoteInfo(NoteInfo(noteB: !value));
    } else {
      mapNote[sec] = Note(sec: sec, noteInfo: NoteInfo(noteB: true));
    }
  }

  Note get_NoteFromIndex(int index) {
    var sortedByKeyMap = Map.fromEntries(mapNote.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    var key = sortedByKeyMap.keys.toList()[index];
    var value = get_NoteFromSec(key)!;

    return value;
  }

  bool check_NoteFromSec(int sec) => mapNote.containsKey(sec);

  Note? get_NoteFromSec(int sec) {
    if (check_NoteFromSec(sec)) {
      return mapNote[sec];
    } else {
      return null;
    }
  }
}
