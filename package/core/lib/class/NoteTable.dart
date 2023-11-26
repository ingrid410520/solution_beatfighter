
class NoteTable {
  int Notelength = 50000;
  Map<int, String> _mapNote_Music = Map();
  Map<int, String> _mapNote_BeatA = Map();
  Map<int, String> _mapNote_BeatG = Map();
  Map<int, String> _mapNote_Event = Map();

  bool insert_Music(int time, String value) {
    _mapNote_Music[time] = value;
    return true;
  }

  bool insert_BeatA(int time, String value) {
    _mapNote_BeatA[time] = value;
    return true;
  }

  bool insert_BeatB(int time, String value) {
    _mapNote_BeatG[time] = value;
    return true;
  }

  bool insert_Event(int time, String value) {
    _mapNote_Event[time] = value;
    return true;
  }
}