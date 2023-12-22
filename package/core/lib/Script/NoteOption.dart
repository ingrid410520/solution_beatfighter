
class NoteOption{
  NoteOption.construct();
  static final _inst = NoteOption.construct();
  factory NoteOption() => _inst;

  Set<String> setBgmOption = {
    "Baki",
    "Undertale1",
  };

  Map<String, String> mapNoteOption = {
    "Normal" : "Normal",
    "Long" : "Long",
  };

  Set<String> setEventKeyOption = {
    "EnemyControl",
    "Explain",
    "ExplainStop",
    "JumpNote"
  };

  Set<String> setSubtitleOption = {
    "Notice",
    "CountDown",
    "EnemySay"
  };

  get get_OptionKey_Bgm => setBgmOption.toList();

  List get_OptionKeys_Note() {
    return mapNoteOption.keys.toList();
  }

  String get_OptionKeyIndex_Note(int index){
    List result = mapNoteOption.keys.toList();

    if (index < mapNoteOption.length) {
      return result[index];
    }

    return "None";
  }

}