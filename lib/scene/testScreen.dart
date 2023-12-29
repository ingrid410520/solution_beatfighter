import 'package:flutter/material.dart';
import 'package:solution_beatfighter/system/AppData.dart';

class testScreen extends StatefulWidget {
  const testScreen({super.key});

  @override
  State<testScreen> createState() => _testScreenState();
}

class _testScreenState extends State<testScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Select Menu"),
          ElevatedButton(onPressed: () { Navigator.pushNamed(context, AppData().dataString.strScreen_Editor); }, child: Text("Editor")),
          ElevatedButton(onPressed: () { Navigator.pushNamed(context, AppData().dataString.strScreen_Play); }, child: Text("Play")),
          ElevatedButton(onPressed: () { }, child: Text("Config")),
        ],
      ),
    );
  }
}
