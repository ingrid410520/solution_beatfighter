import 'package:flutter/material.dart';
import 'package:package_beatfighter/Script/Note.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/system/AppData.dart';

TextEditingController teInsertSubtitleKey = TextEditingController();
TextEditingController teInsertSubtitleValue = TextEditingController();

StatefulBuilder Popup_insertSubtitle(ScriptStock script, int sec) {
  return StatefulBuilder(
    builder: (context, setState) {
      var note = script.get_NoteFromSec(sec);
      int count = 0;
      NoteInfo? noteInfo = null;

      bool checkSubtitle = false;

      if (note != null) {
        count = note.noteInfo.listSubTitle.isEmpty ? 0 : note.noteInfo.listSubTitle.length;
        noteInfo = note.noteInfo;
        checkSubtitle = noteInfo.listSubTitle.isNotEmpty;
      }

      return AlertDialog(
        title: Text("Insert Subtitle (Sec:$sec)"),
        scrollable: true,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            checkSubtitle ? Text("Subtitle Data : ${note!.noteInfo.listSubTitle.length}") : Text("Empty"),
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
                          "$index) ${note!.noteInfo.listSubTitle[index].key} : ${note!.noteInfo.listSubTitle[index].value}"),
                      IconButton(
                        icon: Icon(Icons.cancel_outlined, color: Colors.pink),
                        onPressed: () {
                          setState(() {
                            BFCore().seletedScript.get_NoteFromSec(sec)?.delete_SubTitle(index);
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
                      controller: teInsertSubtitleKey,
                      decoration: InputDecoration(
                        label: Text("Key"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                      ),
                      onChanged: (value) {
                        teInsertSubtitleKey.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextField(
                      controller: teInsertSubtitleValue,
                      decoration: InputDecoration(
                        label: Text("Value"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                      ),
                      onChanged: (value) {
                        teInsertSubtitleValue.text = value;
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
                        if (teInsertSubtitleKey.text != "" && teInsertSubtitleValue.text != "") {
                          SubTitleNote subtitle =
                              SubTitleNote(key: teInsertSubtitleKey.text, value: teInsertSubtitleValue.text);
                          if (note != null) {
                            note?.insert_SubTitle(subtitle);
                          } else {
                            BFCore().seletedScript.insert_Note(sec, NoteInfo());
                            BFCore().seletedScript.get_NoteFromSec(sec)?.insert_SubTitle(subtitle);
                          }
                          teInsertSubtitleKey.clear();
                          teInsertSubtitleValue.clear();
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
