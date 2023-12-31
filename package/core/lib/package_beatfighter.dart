library package_beatfighter;

import 'package:package_beatfighter/Script/NoteOption.dart';
import 'package:package_beatfighter/Player/ScriptPlayer.dart';
import 'package:package_beatfighter/Script/ScriptManager.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/class/ResourceContainer.dart';

class BFCore {
  BFCore._construct() {}
  static final BFCore _inst = BFCore._construct();

  factory BFCore() => _inst;

  void update() {}

  ResourceContainer resourceContainer = ResourceContainer();
  ScriptPlayer scriptPlayer = ScriptPlayer();
  NoteOption noteOption = NoteOption();
  ScriptManager scriptManager = ScriptManager();
  void get bindListener {}

  ScriptStock get seletedScript => scriptManager.get_SelectScript()!;
}
