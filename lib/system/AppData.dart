import 'package:flutter/material.dart';
import 'package:solution_beatfighter/System/Util/Util_Screen.dart';

class AppData {
  AppData._constructor() {}
  static AppData _inst = AppData._constructor();

  factory AppData() => _inst;

  DataString dataString = DataString();
  DataColor color = DataColor();
  Util_Screen utilScreen = Util_Screen();
}

class DataString {
  String strTitle_SolutionApp = "Solution Beat Fighter";
  String strTitle_Package = "package_beat_fighter";
  String strTitle_Editor = "Note Editor : Beat Fighter";
  String strTitle_GameApp = "Beat Fighter";

  String strScreen_Home = "testScreen";
  String strScreen_Editor = "testEditor";
  String strScreen_Play = "testPlay";
}

class DataColor {
  var colorBG_App = Colors.grey[200];
  var colorBG_Appbar = Colors.teal[200];
  var colorBG_CommandBar = Colors.green[300];
  var colorBG_Popup = Color(0xFFE0EBFF);

  var EditorBG_Header = Color(0xFFFF9EB3);
  var EditorBG_Body = Color(0xFF98E187);
  var EditorBG_Footer = Color(0xFF85C2FF);

  var Note_before_Empty = Color(0xFF53D250);
  var Note_before_Filled = Color(0xFF68A1FF);
  var Note_after_Empty = Color(0xFFFF91B3);
  var Note_after_Filled = Color(0xFFBC82FF);
}
