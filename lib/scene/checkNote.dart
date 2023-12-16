import 'package:flutter/material.dart';
import 'package:package_beatfighter/Script/ScriptManager.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

class checkNote extends StatefulWidget {
  const checkNote({super.key});

  @override
  State<checkNote> createState() => _checkNoteState();
}

class _checkNoteState extends State<checkNote> {
  @override
  Widget build(BuildContext context) {
    ScriptStock selectScript = BFCore().seletedScript;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Contents"),
          Container(
            color: Colors.blueGrey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  growable: true,
                  BFCore().seletedScript.get_ScriptLength(),
                  (index) {
                    var noteName = selectScript.get_SortedNote().keys.toList()[index];
                    var noteInfo = selectScript.get_SortedNote().values.toList()[index].get_NoteInfo();
                    var bgm = noteInfo.bgm ?? " - ";
                    var noteA = noteInfo.noteA ?? " - ";
                    var noteB = noteInfo.noteB ?? " - ";


                    return Text("$noteName : bgm:$bgm / A:$noteA / B:$noteB");
                  },
                )
            ),
          ),
          Text(BFCore().seletedScript.get_ScriptName()),
        ],
      ),
    );
  }
}
