import 'package:flutter/material.dart';
import 'package:solution_beatfighter/system/AppData.dart';

class testHome extends StatefulWidget {
  const testHome({super.key});

  @override
  State<testHome> createState() => _testHomeState();
}

class _testHomeState extends State<testHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Select Menu"),
            ElevatedButton(onPressed: () { Navigator.pushNamed(context, AppData().dataString.strScreen_Editor); }, child: Text("Editor")),
            ElevatedButton(onPressed: () { Navigator.pushNamed(context, AppData().dataString.strScreen_Play); }, child: Text("Play")),
            ElevatedButton(onPressed: () { }, child: Text("Config")),
          ],
        ),
      ),
    );
  }
}
