import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

StatefulBuilder Popup_NewScript({VoidCallback? afterFunc}) {
  TextEditingController teNewScriptname = TextEditingController(text: "NewScript");
  TextEditingController teNewLength = TextEditingController(text: "5000");

  return StatefulBuilder(
    builder: (context, setStat) {
      return AlertDialog(
        title: Text("New Script"),
        scrollable: true,
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                  controller: teNewScriptname,
                  decoration: const InputDecoration(
                      label: Text("Name"), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
                  onChanged: (value) {}),
              SizedBox(height: 30),
              TextField(
                  controller: teNewLength,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text("Length"), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
                  onChanged: (value) {}),
            ],
          ),
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Create'),
              onPressed: () {
                String newScriptName = BFCore()
                    .scriptManager
                    .create_ScriptStock(scriptName: teNewScriptname.text, scriptLength: int.parse(teNewLength.text));
                bool result = BFCore().scriptManager.select_ScriptStock(newScriptName);

                // print(newScriptName);
                // print(result);

                if (afterFunc != null) {
                  afterFunc!();
                }
                setStat;
                Navigator.of(context).pop();
              }),
          TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}
