import 'package:flutter/material.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/System/AppData.dart';
import 'package:solution_beatfighter/scene/checkNote.dart';
import 'package:solution_beatfighter/scene/testEditor.dart';
import 'package:solution_beatfighter/scene/testScreen.dart';

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
      title: AppData().string.strTitle_SolutionApp,
      initialRoute: "testEditor",
      routes: {
        "testScreen" : (context) => testScreen(),
        "testEditor" : (context) => testEditor(),
        "testPlay" : (context) => testScreen(),
      },
    );
  }
}
