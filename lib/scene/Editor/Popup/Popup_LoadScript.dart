import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/system/AppData.dart';

StatefulBuilder Popup_LoadScript({VoidCallback? afterFunc}) {
  return StatefulBuilder(
    builder: (context, setStat) {
      return AlertDialog(
        title: const Text("Load Script"),
        scrollable: true,
        content: Center(
          child: SizedBox(
            width: AppData().utilScreen.Screen(context).width * 0.3,
            height: AppData().utilScreen.Screen(context).height * 0.5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: ListView.builder(
                itemCount: BFCore().scriptManager.get_ScriptKeys().length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  List listScript = BFCore().scriptManager.get_ScriptKeys();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          child: Text("${listScript[index]}"),
                          onPressed: () {
                            BFCore().scriptManager.select_ScriptStock(listScript[index]);
                            if (afterFunc != null) {
                              afterFunc!();
                            }
                            setStat;
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      IconButton(onPressed: () {
                        BFCore().scriptManager.remove_Script(listScript[index]);
                      }, icon: const Icon(Icons.cancel_outlined))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        actions: [
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
