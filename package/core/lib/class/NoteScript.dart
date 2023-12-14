import 'package:audioplayers/audioplayers.dart';

class NoteScript {
  NoteScript({required this.sec, this.bgm, this.noteA = false, noteB = false});

  int sec = 0;
  bool playDone = false;
  String? bgm;
  AudioPlayer? bgmPlayer;
  bool noteA = false;
  bool noteB = false;
  List<EventNote> listEvent = List<EventNote>.empty(growable: true);
  List<SubTitleNote> listSubTitle = List<SubTitleNote>.empty(growable: true);

  void initScript(){
    bgm = null;
    bgmPlayer?.release();
    noteA = false;
    noteB = false;
    listEvent.clear();
    listSubTitle.clear();
  }

  void addScript(NoteScript script) {
    if (script.bgm != null) bgm = script.bgm;
    if (script.noteA) noteA = script.noteA;
    if (script.noteB) noteB = script.noteB;
    if (script.listEvent.isNotEmpty) listEvent = script.listEvent;
    if (script.listSubTitle.isNotEmpty) listSubTitle = script.listSubTitle;
  }

  void printScriptInfo() {
    print("sec:$sec-$playDone-bgm:$bgm-Note($noteA/$noteB)-Event($listEvent)-Subtitle($listSubTitle)");
  }

  void playScript() {
    playDone = true;
    if (bgm != null) {
      print("bgm on");
    }
    if (noteA) {
      print("Note A : $noteA");
    }
    if (noteB) {
      print("Note B : $noteB");
    }
    if (listEvent.isNotEmpty) {
      print("Event($listEvent)");
    }
    if (listSubTitle.isNotEmpty) {
      print("Subtitle($listSubTitle)");
    }
  }

  bool getPlayDone() => playDone;

  void setPlayDone(bool value) => playDone = value;

  bool setPlayDoneInit() => playDone = false;

  void insertEvent(EventNote event) => listEvent.add(event);

  bool deleteEvent(int index) {
    if (listEvent.length < index) return false;
    listEvent.removeAt(index);
    return true;
  }

  bool modifyEvent(int index, EventNote _event) {
    if (listEvent.length < index) return false;
    listEvent[index] = _event;
    return true;
  }

  void insertSubTitle(SubTitleNote _subTitle) => listSubTitle.add(_subTitle);

  bool deleteSubTitle(int index) {
    if (listSubTitle.length < index) return false;
    listSubTitle.removeAt(index);
    return true;
  }

  bool modifySubTitle(int index, SubTitleNote _subTitle) {
    if (listSubTitle.length < index) return false;
    listSubTitle[index] = _subTitle;
    return true;
  }

}

enum EventState { none, hitCheck }

class EventNote {
  EventNote({required this.eventState, this.listParam});

  final EventState eventState;
  List? listParam = [];
}

class SubTitleNote {
  SubTitleNote({required this.key, required this.value});

  String key = "";
  String value = "";
}
