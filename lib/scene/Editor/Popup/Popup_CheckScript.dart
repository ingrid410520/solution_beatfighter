
import 'package:flutter/material.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/system/AppData.dart';

Widget Popup_CheckScript(BuildContext context, ScriptStock selectScript) {
  return Container(
    width: AppData().utilScreen.Screen(context).width * 0.5,
    height: AppData().utilScreen.Screen(context).height * 0.5,
    child: AlertDialog(
      title: Text(BFCore().seletedScript.get_ScriptName()),
      scrollable: true,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          selectScript.mapNote.isEmpty == true
              ? Text("Empty")
              : Text(
            selectScript.get_ScriptInfo(),
            textAlign: TextAlign.left,
          )
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Go to TestPlay'),
          onPressed: () {
            Navigator.pushNamed(context, AppData().dataString.strScreen_Play);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancle'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}