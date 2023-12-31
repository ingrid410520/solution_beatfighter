import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/scene/Editor/Popup/Popup_LoadScript.dart';
import 'package:solution_beatfighter/scene/Editor/Popup/Popup_NewScript.dart';

int seperated = 100;
TextEditingController teScriptname = TextEditingController(text: BFCore().seletedScript.get_ScriptName());
TextEditingController teSeperated = TextEditingController(text: seperated.toString());
TextEditingController teLength = TextEditingController(text: BFCore().seletedScript.get_ScriptLength().toString());

class UI_ScriptInfo extends StatelessWidget {
  const UI_ScriptInfo({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            child: Text("New Script"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Popup_NewScript(afterFunc: () {
                      teScriptname.text = BFCore().seletedScript.get_ScriptName();
                      teLength.text = BFCore().seletedScript.get_ScriptLength().toString();
                    });
                  });
            }),
        ElevatedButton(
            child: Text("Load Script"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Popup_LoadScript(afterFunc: () {
                      teScriptname.text = BFCore().seletedScript.get_ScriptName();
                      teLength.text = BFCore().seletedScript.get_ScriptLength().toString();
                    });
                  });
            }),
        SizedBox(
          width: 150,
          height: 35,
          child: TextField(
            controller: teScriptname,
            onChanged: (value) {
              teScriptname.text = value;
            },
            decoration: InputDecoration(
              label: Text("ScriptName"),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              suffixIcon: IconButton(
                  onPressed: () {
                    BFCore().seletedScript.change_ScriptName(teScriptname.text);
                  },
                  icon: Icon(Icons.input)),
            ),
          ),
        ),
        SizedBox(
          width: 150,
          height: 35,
          child: TextField(
            controller: teLength,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              teLength.text = value;
            },
            decoration: InputDecoration(
                label: Text("Script Length"),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                suffixIcon: IconButton(
                    onPressed: () {
                      BFCore().scriptManager.get_SelectScript()!.set_ScriptLength(int.parse(teLength.text));
                    },
                    icon: Icon(Icons.input))),
          ),
        ),
        SizedBox(
          width: 150,
          height: 35,
          child: TextField(
            controller: teSeperated,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              teSeperated.text = value;
            },
            decoration: InputDecoration(
                label: Text("Seperated"),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                suffixIcon: IconButton(
                    onPressed: () {
                      seperated = int.parse(teSeperated.text);
                    },
                    icon: Icon(Icons.input))),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                child: Text("Reload"),
                onPressed: () {
                  BFCore().scriptManager.load();
                }),
            SizedBox(width: 5),
            ElevatedButton(
                child: Text("File Save"),
                onPressed: () {
                  BFCore().scriptManager.save();
                }),
          ],
        ),
      ],
    );
  }
}
