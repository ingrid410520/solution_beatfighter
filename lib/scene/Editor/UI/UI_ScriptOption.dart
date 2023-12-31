import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/scene/Editor/Popup/Popup_CheckScript.dart';

String _UIselectedBgm = BFCore().noteOption.get_OptionKey_Bgm[0];
ValueNotifier<String> _UIselectedNote = ValueNotifier(BFCore().noteOption.get_OptionKeyIndex_Note(0));

class UI_ScriptOption extends StatelessWidget {
  const UI_ScriptOption({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Temp1"),
        DropdownButton(
            items: List.generate(
                BFCore().noteOption.setBgmOption.length,
                (index) => DropdownMenuItem(
                    value: BFCore().noteOption.get_OptionKey_Bgm[index],
                    child: Text(BFCore().noteOption.get_OptionKey_Bgm[index]))),
            value: _UIselectedBgm,
            onChanged: (value) {
              _UIselectedBgm = value.toString();
            }),
        Row(children: [
          AdvancedSegment(
            segments: BFCore().noteOption.mapNoteOption,
            controller: _UIselectedNote,
          ),
          SizedBox(width: 20),
          Text("Note JudgeTime"),
        ]),
        ElevatedButton(child: Text("All Clear"), onPressed: () {}),
        ElevatedButton(
            child: Text("Check Script"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    ScriptStock selectScript = BFCore().seletedScript;
                    return Popup_CheckScript(context, selectScript);
                  });
            }),
      ],
    );
  }
}
