import 'package:flutter/material.dart';
import 'package:solution_beatfighter/scene/Editor/testEditor.dart';
import 'package:solution_beatfighter/scene/Play/testPlay.dart';
import 'package:solution_beatfighter/scene/testHome.dart';
import 'package:solution_beatfighter/system/AppData.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      title: AppData().dataString.strTitle_SolutionApp,
      initialRoute: AppData().dataString.strScreen_Editor,
      routes: {
        AppData().dataString.strScreen_Home : (context) => testHome(),
        AppData().dataString.strScreen_Editor : (context) => testEditor(),
        AppData().dataString.strScreen_Play : (context) => testPlay(),
      },
    );
  }
}
