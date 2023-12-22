import 'package:package_beatfighter/Script/Note.dart';

int _initScriptLength = 5000;

class ScriptStock {
  ScriptStock({required String scriptName, required int length})
      : _scriptName = scriptName,
        _scriptLength = length {}
  final String _scriptName;
  int _scriptLength = _initScriptLength;
  Map<int, Note> mapNote = Map<int, Note>();

  String get_ScriptName() => _scriptName;

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
