import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:package_beatfighter/Script/Note.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/System/AppData.dart';

int seperated = 100;
TextEditingController teSeperated = TextEditingController(text: seperated.toString());
TextEditingController teLength =
    TextEditingController(text: BFCore().scriptManager.get_SelectScript()!.get_ScriptLength().toString());
TextEditingController teInsertEventKey = TextEditingController();
TextEditingController teInsertEventValue = TextEditingController();
TextEditingController teInsertSubtitleKey = TextEditingController();
TextEditingController teInsertSubtitleValue = TextEditingController();

class testEditor extends StatefulWidget {
  testEditor({super.key});

  late Timer timer;

  @override
  State<testEditor> createState() => _testEditorState();
}

class _testEditorState extends State<testEditor> {
  int ratio_Header = 2;
  int ratio_Body = 7;
  int ratio_Footer = 2;
  var _ScrollController = ScrollController();

  String _UIselectedBgm = BFCore().noteOption.get_OptionKey_Bgm[0];
  final _UIselectedNote = ValueNotifier(BFCore().noteOption.get_OptionKeyIndex_Note(0));

  @override
  void initState() {
    super.initState();
    if (mounted) {
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.timer.cancel();
    _ScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //update();
    return Scaffold(
      appBar: AppBar(
          title: Text("Test Page"),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "testScreen");
              },
              icon: Icon(Icons.home))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Header(),
            Body(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget Header() {
    return Expanded(
        flex: ratio_Header,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: AppData().color.EditorBG_Header,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Save")),
                  ElevatedButton(onPressed: () {}, child: Text("Load")),
                  Text("Filename"),
                  Row(
                    children: [
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
                                    setState(() {
                                      seperated = int.parse(teSeperated.text);
                                    });
                                  },
                                  icon: Icon(Icons.input))),
                        ),
                      ),
                      SizedBox(width: 20),
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
                              label: Text("Note Length"),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      BFCore().scriptManager.get_SelectScript()!.set_ScriptLength(int.parse(teLength.text));
                                    });
                                  },
                                  icon: Icon(Icons.input))),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            ScriptStock selectScript = BFCore().seletedScript;
                            return checkScript(context, selectScript);
                          },
                        );
                      },
                      child: Text("Check Script"))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Data1"),
                  DropdownButton(
                    items: List.generate(
                        BFCore().noteOption.setBgmOption.length,
                        (index) => DropdownMenuItem(
                            value: BFCore().noteOption.get_OptionKey_Bgm[index],
                            child: Text(BFCore().noteOption.get_OptionKey_Bgm[index]))),
                    value: _UIselectedBgm,
                    onChanged: (value) {
                      _UIselectedBgm = value.toString();
                    },
                  ),
                  Row(
                    children: [
                      AdvancedSegment(
                        segments: BFCore().noteOption.mapNoteOption,
                        controller: _UIselectedNote,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Note JudgeTime"),
                    ],
                  ),
                  Text("test"),
                  Text("All Clear"),
                ],
              ),
            ],
          ),
        ));
  }

  Container checkScript(BuildContext context, ScriptStock selectScript) {
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
                : Column(
                    children: List.generate(
                    selectScript.mapNote.length,
                    (index) {
                      var noteSec = selectScript.get_SortedNote().keys.toList()[index];
                      var noteInfo = selectScript.get_SortedNote().values.toList()[index].get_NoteInfo();
                      var bgm = noteInfo.bgm ?? " - ";
                      var noteA = noteInfo.noteA ? "O" : "X";
                      var noteB = noteInfo.noteB ? "O" : "X";
                      var eventCount = noteInfo.listEvent.length;
                      var subtitleCount = noteInfo.listSubTitle.length;
                      return Text("$noteSec) : bgm:$bgm / A:$noteA B:$noteB / Event:$eventCount Subtitle:$subtitleCount");
                    },
                  ))
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Go to Test'),
            onPressed: () {},
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

  Widget Body() {
    final script = BFCore().scriptManager.get_SelectScript()!;
    double buttonSize = AppData().utilScreen.Screen(context).width * 0.13;
    double buttonSize1 = AppData().utilScreen.Screen(context).width * 0.08;
    int ratio_sec = 2;
    int ratio_small = 2;
    int ratio_middle = 3;
    int ratio_big = 5;
    int ratio_icon = 1;
    int count = (BFCore().seletedScript.get_ScriptLength() ~/ seperated).toInt();
    return Expanded(
        flex: ratio_Body,
        child: Container(
          padding: EdgeInsets.all(3),
          width: double.maxFinite,
          height: double.maxFinite,
          color: AppData().color.EditorBG_Body,
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _ScrollController,
              itemCount: count,
              itemBuilder: (context, index) {
                int sec = index * seperated;
                int secNow = BFCore().scriptPlayer.get_PlayTime();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Note_sec(ratio_sec, buttonSize1, sec, () {
                      _ScrollController.animateTo(get_Scrollpos(secNow),
                          duration: Duration(milliseconds: 5), curve: Curves.easeInOut);
                    }),
                    Note_bgm(ratio_middle, buttonSize, sec, () {}),
                    Note_AB(ratio_big, buttonSize, sec, () {
                      setState(() {
                        script.reverse_NoteA(sec);
                      });
                    }, () {
                      setState(() {
                        script.reverse_NoteB(sec);
                      });
                    }),
                    Note_Event(ratio_middle, buttonSize, sec, () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return popup_insertEvent(script, sec);
                        },
                      );
                    }),
                    Note_subTitle(ratio_small, sec, () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return popup_insertSubtitle(script, sec);
                        },
                      );
                    }),
                    Expanded(
                      flex: ratio_icon,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.pink),
                          onPressed: () {
                            BFCore().seletedScript.delete_Note(sec);
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }

  StatefulBuilder popup_insertEvent(ScriptStock script, int sec) {
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

        return Container(
          width: AppData().utilScreen.Screen(context).width * 0.7,
          height: AppData().utilScreen.Screen(context).height * 0.5,
          child: AlertDialog(
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
          ),
        );
      },
    );
  }

  StatefulBuilder popup_insertSubtitle(ScriptStock script, int sec) {
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

        return Container(
          width: AppData().utilScreen.Screen(context).width * 0.7,
          height: AppData().utilScreen.Screen(context).height * 0.5,
          child: AlertDialog(
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
          ),
        );
      },
    );
  }

  double get_Scrollpos(int timeNow) {
    double scrollMax = _ScrollController.position.maxScrollExtent;
    int noteMax = BFCore().seletedScript.get_ScriptLength();
    int now = timeNow;

    double cali = noteMax * 0.01;
    double pos = (scrollMax * now + 10) / noteMax;

    //print("scrollMax:$scrollMax - noteMax:$noteMax - now:$now - pos:$pos");
    return pos;
  }

  Widget Note_sec(int ratio_sec, double buttonSize1, int sec, Null function()) {
    int time = BFCore().scriptPlayer.get_PlayTime();
    Color colorA = (sec < time) ? AppData().color.Note_after_Empty : AppData().color.Note_before_Empty;

    if (BFCore().scriptPlayer.isRun) {
      int cc = sec % 1000;
      if (cc == 0) {
        function();
      }
    }
    return Expanded(
        flex: ratio_sec,
        child: Container(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: buttonSize1,
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(colorA)),
                        child: Text("$sec"),
                        onPressed: function)),
              ],
            )));
  }

  Widget Note_bgm(int ratio_middle, double buttonSize, sec, Null function()) {
    return Expanded(
        flex: ratio_middle,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: buttonSize, child: ElevatedButton(child: Text("Bgm"), onPressed: function)),
              ],
            )));
  }

  Widget Note_AB(int ratio_big, double buttonSize, sec, Null functionA(), Null functionB()) {
    ScriptStock script = BFCore().seletedScript;
    var note = script.get_NoteFromSec(sec);

    bool checkA = false;
    bool checkB = false;
    int time = BFCore().scriptPlayer.get_PlayTime();

    if (note != null) {
      if (note.get_NoteInfo().noteA) checkA = true;
      if (note.get_NoteInfo().noteB) checkB = true;
    }

    Color colorA = (sec < time)
        ? (checkA ? AppData().color.Note_after_Filled : AppData().color.Note_after_Empty)
        : (checkA ? AppData().color.Note_before_Filled : AppData().color.Note_before_Empty);

    Color colorB = (sec < time)
        ? (checkB ? AppData().color.Note_after_Filled : AppData().color.Note_after_Empty)
        : (checkB ? AppData().color.Note_before_Filled : AppData().color.Note_before_Empty);

    return Expanded(
        flex: ratio_big,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: buttonSize,
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(colorA)),
                    child: Text("Note A"),
                    onPressed: functionA)),
            SizedBox(width: 10),
            Container(
                width: buttonSize,
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(colorB)),
                    child: Text("Note B"),
                    onPressed: functionB)),
          ]),
        ));
  }

  Expanded Note_Event(int ratio_middle, double buttonSize, sec, Null function()) {
    ScriptStock script = BFCore().seletedScript;
    var note = script.get_NoteFromSec(sec);
    bool checkA = false;
    int time = BFCore().scriptPlayer.get_PlayTime();

    if (note != null) {
      if (note.get_NoteInfo().listEvent.isNotEmpty) {
        checkA = true;
      }
    }

    Color color = (sec < time)
        ? (checkA ? AppData().color.Note_after_Filled : AppData().color.Note_after_Empty)
        : (checkA ? AppData().color.Note_before_Filled : AppData().color.Note_before_Empty);

    return Expanded(
        flex: ratio_middle,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: buttonSize,
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(color)),
                        child: Text("Event"),
                        onPressed: function)),
              ],
            )));
  }

  Expanded Note_subTitle(int ratio_small, sec, Null function()) {
    ScriptStock script = BFCore().seletedScript;
    var note = script.get_NoteFromSec(sec);
    bool checkA = false;
    int time = BFCore().scriptPlayer.get_PlayTime();

    if (note != null) {
      if (note.get_NoteInfo().listSubTitle.isNotEmpty) {
        checkA = true;
      }
    }

    Color color = (sec < time)
        ? (checkA ? AppData().color.Note_after_Filled : AppData().color.Note_after_Empty)
        : (checkA ? AppData().color.Note_before_Filled : AppData().color.Note_before_Empty);

    return Expanded(
        flex: ratio_small,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(color)),
                    child: Text("SubTitle"),
                    onPressed: function),
              ],
            )));
  }

  Widget Footer() {
    final player = BFCore().scriptPlayer;
    return Expanded(
        flex: ratio_Footer,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: AppData().color.EditorBG_Footer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(player.get_PlayTime_inFormat() + "   ms : " + player.get_PlayTime().toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(child: const Text("Play"), onPressed: () => player.set_Play()),
                  OutlinedButton(child: const Text("Pause"), onPressed: () => player.set_Pause()),
                  OutlinedButton(child: const Text("Stop"), onPressed: () => player.set_Stop()),
                ],
              )
            ],
          ),
        ));
  }

  void update() {
    widget.timer = Timer.periodic(
      Duration(milliseconds: 5),
      (timer) {
        setState(() {});
      },
    );
  }
}
