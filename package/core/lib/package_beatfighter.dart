library package_beatfighter;

import 'package:package_beatfighter/class/NotePlayer.dart';
import 'package:package_beatfighter/class/NoteTable.dart';
import 'package:package_beatfighter/class/ResourceContainer.dart';

class BFCore {
  BFCore._construct() {}
  static final BFCore _inst = BFCore._construct();

  factory BFCore() => _inst;

  void update() {}

  NoteTable noteTable = NoteTable();
  ResourceContainer resourceContainer = ResourceContainer();
  NotePlayer notePlayer = NotePlayer();
}
