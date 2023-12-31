import 'package:flutter/material.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/system/AppData.dart';

class testPlay extends StatefulWidget {
  const testPlay({super.key});

  @override
  State<testPlay> createState() => _testPlayState();
}

class _testPlayState extends State<testPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, AppData().dataString.strScreen_Home);
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${BFCore().seletedScript.get_ScriptName()}"),
            Text("${BFCore().seletedScript.get_ScriptInfo()}")

          ],
        ),
      ),
    );
  }
}
