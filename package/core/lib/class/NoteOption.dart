
class NoteOption{

  Map mapBgmOption = {
    "Baki" : "Baki",
    "Undertale" : "Undertale",
  };

  Map<String, String> mapNoteOption = {
    "Normal" : "Normal",
    "LongTap" : "Long",
  };

  get get_OptionKey_Bgm => mapBgmOption.keys.toList();

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