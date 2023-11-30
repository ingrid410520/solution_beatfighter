class NoteScript {
  NoteScript({required this.sec, this.bgm, this.noteA, this.noteB});

  int sec = 0;
  String? bgm;
  bool? noteA = false;
  bool? noteB = false;
  List<EventNote> listEvent = List<EventNote>.empty(growable: true);
  List<SubTitleNote> listSubTitle = List<SubTitleNote>.empty(growable: true);

  void insertEvent(EventNote _event) => listEvent.add(_event);

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

  void addScript(NoteScript script) {
    if (script.bgm != null) bgm = script.bgm;
    if (script.noteA != null) noteA = script.noteA;
    if (script.noteB != null) noteB = script.noteB;
    if (script.listEvent.isNotEmpty) listEvent = script.listEvent;
    if (script.listSubTitle.isNotEmpty) listSubTitle = script.listSubTitle;
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
