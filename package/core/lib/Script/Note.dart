import 'package:audioplayers/audioplayers.dart';

class Note {
  Note({required int sec, required this.noteInfo}) : _sec = sec;

  final int _sec;
  bool playDone = false;
  AudioPlayer? bgmPlayer;
  NoteInfo noteInfo;

  int get sec => _sec;

  bool get_PlayDone() => playDone;

  void set_PlayDone(bool value) => playDone = value;

  void init_PlayDone() {
    playDone = false;
    // bgm check
  }

  void init_NoteInfo() {
    noteInfo.bgm = null;
    bgmPlayer?.release();
    noteInfo.noteA = false;
    noteInfo.noteB = false;
    noteInfo.listEvent.clear();
    noteInfo.listSubTitle.clear();
  }

  void cover_NoteInfo(NoteInfo info) {
    if (info.bgm != null) noteInfo.bgm = info.bgm;
    noteInfo.noteA = info.noteA;
    noteInfo.noteB = info.noteB;
    if (info.listEvent.isNotEmpty) noteInfo.listEvent = info.listEvent;
    if (info.listSubTitle.isNotEmpty) noteInfo.listSubTitle = info.listSubTitle;
  }

  NoteInfo get_NoteInfo() => noteInfo;

  void set_NoteInfo(NoteInfo info) {
    noteInfo = info;
  }

  void print_NoteInfo() {
    print(
        "sec:$sec-$playDone-bgm:$noteInfo.bgm-Note($noteInfo.noteA/$noteInfo.noteB)-Event($noteInfo.listEvent)-Subtitle($noteInfo.listSubTitle)");
  }

  void play_Note() {
    playDone = true;
    if (noteInfo.bgm != null) {
      print("$sec - bgm on");
    }
    if (noteInfo.noteA) {
      print("$sec - Note A : ${noteInfo.noteA}");
    }
    if (noteInfo.noteB) {
      print("$sec - Note B : ${noteInfo.noteB}");
    }
    if (noteInfo.listEvent.isNotEmpty) {
      print("$sec - Event(${noteInfo.listEvent})");
    }
    if (noteInfo.listSubTitle.isNotEmpty) {
      print("$sec - Subtitle(${noteInfo.listSubTitle})");
    }
  }

  void insert_Event(EventNote event) => noteInfo.listEvent.add(event);

  bool delete_Event(int index) {
    if (noteInfo.listEvent.length < index) return false;
    noteInfo.listEvent.removeAt(index);
    return true;
  }

  bool modify_Event(int index, EventNote _event) {
    if (noteInfo.listEvent.length < index) return false;
    noteInfo.listEvent[index] = _event;
    return true;
  }

  void insert_SubTitle(SubTitleNote _subTitle) => noteInfo.listSubTitle.add(_subTitle);

  bool delete_SubTitle(int index) {
    if (noteInfo.listSubTitle.length < index) return false;
    noteInfo.listSubTitle.removeAt(index);
    return true;
  }

  bool modify_SubTitle(int index, SubTitleNote _subTitle) {
    if (noteInfo.listSubTitle.length < index) return false;
    noteInfo.listSubTitle[index] = _subTitle;
    return true;
  }
}

class NoteInfo {
  NoteInfo({this.bgm, this.noteA = false, this.noteB = false});

  String? bgm;
  bool noteA;
  bool noteB;
  List<EventNote> listEvent = List<EventNote>.empty(growable: true);
  List<SubTitleNote> listSubTitle = List<SubTitleNote>.empty(growable: true);
}

enum EventState { none, hitCheck }

class EventNote {
  EventNote({required this.eventKey, required this.eventValue});

  final String eventKey;
  final String eventValue;
}

class SubTitleNote {
  SubTitleNote({required this.key, required this.value});

  final String key;
  final String value;
}
