library package_beatfighter;

import 'package:flutter/material.dart';
import 'package:package_beatfighter/Script/Note.dart';
import 'package:package_beatfighter/Script/NoteOption.dart';
import 'package:package_beatfighter/Player/ScriptPlayer.dart';
import 'package:package_beatfighter/Script/ScriptManager.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/class/ResourceContainer.dart';
import 'package:provider/provider.dart';

class BFCore {
  BFCore._construct() {}
  static final BFCore _inst = BFCore._construct();

  factory BFCore() => _inst;
  BuildContext? BFcontext;

  void runBFApp(Widget app){

    return runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) {
        BFcontext = context;
        return NoteNotifier();
      },)
    ], child: app,));
  }

  void update() {}

  ResourceContainer resourceContainer = ResourceContainer();
  ScriptPlayer scriptPlayer = ScriptPlayer();
  NoteOption noteOption = NoteOption();
  ScriptManager scriptManager = ScriptManager();
  void get bindListener {}

  ScriptStock get seletedScript => scriptManager.get_SelectScript()!;
}

class NoteNotifier extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  Note? note;

  void NoteSet(Note inst) {
    note = inst;
    // 상태 변경을 알림
    notifyListeners();
  }


}
