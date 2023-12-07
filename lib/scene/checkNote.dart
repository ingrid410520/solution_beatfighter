import 'package:flutter/material.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

class checkNote extends StatefulWidget {
  const checkNote({super.key});

  @override
  State<checkNote> createState() => _checkNoteState();
}

class _checkNoteState extends State<checkNote> {
  @override
  Widget build(BuildContext context) {
    var mapScript = BFCore().notePlayer.get_NoteScript();
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
                  BFCore().notePlayer.mapNoteScript.length,
                  (index) {
                    var key = mapScript.keys.toList()[index];
                    var result = mapScript.values.toList()[index];
                    var bgm = result.bgm ?? " - ";
                    var noteA = result.noteA ?? " - ";
                    var noteB = result.noteB ?? " - ";

                    return Text("$key : bgm:$bgm / A:$noteA / B:$noteB");
                  },
                )
            ),
          ),
          Text( BFCore().notePlayer.get_NoteScript().toString()),
        ],
      ),
    );
  }
}
