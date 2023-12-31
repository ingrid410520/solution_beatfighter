import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/system/AppData.dart';

StatefulBuilder Popup_LoadScript({VoidCallback? afterFunc}) {
  return StatefulBuilder(
    builder: (context, setStat) {
      return AlertDialog(
        title: Text("Load Script"),
        scrollable: true,
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: AppData().utilScreen.Screen(context).width * 0.3,
                  height: AppData().utilScreen.Screen(context).height * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListView.builder(
                          itemCount: BFCore().scriptManager.get_ScriptKeys().length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            List listScript = BFCore().scriptManager.get_ScriptKeys();

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                            );
                          },
                        )
                      ],
                    ),
                  )),
            ],
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
