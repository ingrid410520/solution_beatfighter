import 'package:flutter/material.dart';
import 'package:solution_beatfighter/System/Util/Util_Screen.dart';

class AppData {
  AppData._constructor() {}
  static AppData _inst = AppData._constructor();
  factory AppData() => _inst;

  DataString string = DataString();
  DataColor color = DataColor();
  Util_Screen utilScreen = Util_Screen();
}

class DataString{
  String strTitle_SolutionApp = "Solution Beat Fighter";
  String strTitle_Package = "package_beat_fighter";
  String strTitle_Editor = "Note Editor : Beat Fighter";
  String strTitle_GameApp = "Beat Fighter";
}

class DataColor{
  var colorBG_App = Colors.grey[200];
  var colorBG_Appbar =  Colors.teal[200];
  var colorBG_CommandBar = Colors.green[300];

  var Note_before_Empty = Color(0xFF8CF589);
  var Note_before_Filled = Color(0xFF68A1FF);
  var Note_after_Empty = Color(0xFFFF91B3);
  var Note_after_Filled = Color(0xFFBC82FF);
}
