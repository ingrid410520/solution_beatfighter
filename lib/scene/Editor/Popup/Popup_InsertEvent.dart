import 'package:flutter/material.dart';
import 'package:package_beatfighter/Script/Note.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/system/AppData.dart';

TextEditingController teInsertEventKey = TextEditingController();
TextEditingController teInsertEventValue = TextEditingController();

StatefulBuilder Popup_insertEvent(ScriptStock script, int sec) {
  return StatefulBuilder(
    builder: (context, setState) {
      var note = script.get_NoteFromSec(sec);
      int count = 0;
      NoteInfo? noteInfo = null;

      bool CheckEvent = false;

      if (note != null) {
        count = note.noteInfo.listEvent.isEmpty ? 0 : note.noteInfo.listEvent.length;
        noteInfo = note.noteInfo;
        CheckEvent = noteInfo.listEvent.isNotEmpty;
      }

      return AlertDialog(
        title: Text("Insert Event (Sec:$sec)"),
        scrollable: true,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CheckEvent ? Text("Event Data : ${note!.noteInfo.listEvent.length}") : Text("Empty"),
            SizedBox(
              width: AppData().utilScreen.Screen(context).width * 0.5,
              height: AppData().utilScreen.Screen(context).height * 0.5,
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          style: TextStyle(fontSize: 20),
                          "$index) ${note!.noteInfo.listEvent[index].eventKey} : ${note!.noteInfo.listEvent[index].eventValue}"),
                      IconButton(
                        icon: Icon(Icons.cancel_outlined, color: Colors.pink),
                        onPressed: () {
                          setState(() {
                            BFCore().seletedScript.get_NoteFromSec(sec)?.delete_Event(index);
                          });
                        },
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: AppData().utilScreen.Screen(context).width * 0.5,
              height: AppData().utilScreen.Screen(context).height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextField(
                      controller: teInsertEventKey,
                      decoration: InputDecoration(
                        label: Text("Key"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                      ),
                      onChanged: (value) {
                        teInsertEventKey.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextField(
                      controller: teInsertEventValue,
                      decoration: InputDecoration(
                        label: Text("Value"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                      ),
                      onChanged: (value) {
                        teInsertEventValue.text = value;
                      },
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Add'),
                    onPressed: () {
                      setState(() {
                        if (teInsertEventKey.text != "" && teInsertEventValue.text != "") {
                          EventNote event = EventNote(eventKey: teInsertEventKey.text, eventValue: teInsertEventValue.text);
                          if (note != null) {
                            note?.insert_Event(event);
                          } else {
                            BFCore().seletedScript.insert_Note(sec, NoteInfo());
                            BFCore().seletedScript.get_NoteFromSec(sec)?.insert_Event(event);
                          }
                          teInsertEventKey.clear();
                          teInsertEventValue.clear();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}