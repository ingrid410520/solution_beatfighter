import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_beatfighter/Script/Note.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:provider/provider.dart';
import 'package:solution_beatfighter/system/AppData.dart';

class testPlay extends StatefulWidget {
  testPlay({super.key});

  late Timer timer;

  @override
  State<testPlay> createState() => _testPlayState();
}

List strListenMsg = [];

class _testPlayState extends State<testPlay> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.timer.cancel();
  }

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
            Text("${BFCore().seletedScript.get_ScriptInfo()}"),
            Container(
              width: AppData().utilScreen.Screen(context).width * 0.5,
              height: AppData().utilScreen.Screen(context).height * 0.4,
              color: Colors.green,
              child: Center(
                child: Consumer<NoteNotifier>(
                  builder: (context, value, child) {
                    String result = "";
                    if (value.note != null) {
                      Note info = value.note!;
                      String temp = "${info.sec} : ${info.noteInfo.toJson()}";
                      strListenMsg.add(temp);
                      if (10 < strListenMsg.length) {
                        strListenMsg.removeAt(0);
                      }

                      strListenMsg.forEach((element) {
                        result += element + "\n";
                      });
                    }

                    return Text(result);
                  },
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  strListenMsg.clear();
                },
                child: Text("reset")),
            Container(
              width: AppData().utilScreen.Screen(context).width * 0.5,
              height: AppData().utilScreen.Screen(context).height * 0.1,
              child: Footer(),
            )
          ],
        ),
      ),
    );
  }

  Widget Footer() {
    final player = BFCore().scriptPlayer;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(player.get_PlayTime_inFormat() + "   ms : " + player.get_PlayTime().toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(child: const Text("Play"), onPressed: () => player.set_Play()),
            OutlinedButton(child: const Text("Pause"), onPressed: () => player.set_Pause()),
            OutlinedButton(child: const Text("Stop"), onPressed: () => player.set_Stop()),
          ],
        )
      ],
    );
  }

  void update() {
    widget.timer = Timer.periodic(
      Duration(milliseconds: 5),
      (timer) {
        setState(() {});
      },
    );
  }
}
