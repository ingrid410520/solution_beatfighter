import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:package_beatfighter/class/NotePlayer.dart';
import 'package:package_beatfighter/class/NoteScript.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/System/AppData.dart';

class TestScreen extends StatefulWidget {
  TestScreen({super.key});

  late Timer timer;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

var _ScrollController = ScrollController();
bool scrollInit = false;

class _TestScreenState extends State<TestScreen> {
  int ratio_Header = 2;
  int ratio_Body = 7;
  int ratio_Footer = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.timer.cancel();
    _ScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    update();
    return Scaffold(
      appBar: AppBar(title: Text("Test Page")),
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
          color: Colors.pinkAccent,
        ));
  }

  Widget Body() {
    final player = BFCore().notePlayer;
    double buttonSize = AppData().utilScreen.Screen(context).width * 0.13;
    double buttonSize1 = AppData().utilScreen.Screen(context).width * 0.08;
    int ratio_sec = 2;
    int ratio_small = 2;
    int ratio_middle = 3;
    int ratio_big = 5;
    int seperated = 100;
    int count = (BFCore().notePlayer.get_NoteScriptLength() * 0.01).toInt();
    return Expanded(
        flex: ratio_Body,
        child: Container(
          padding: EdgeInsets.all(3),
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.greenAccent,
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _ScrollController,
              itemCount: count,
              itemBuilder: (context, index) {
                int sec = index * seperated;
                _ScrollController.addListener(() {
                  //print('현재 스크롤 위치: ${_ScrollController.offset}');
                });

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Note_sec(ratio_sec, buttonSize1, sec, () {
                      _ScrollController.animateTo(getScrollpos(player), duration: Duration(milliseconds: 5), curve: Curves.easeInOut);
                    }),
                    Note_bgm(ratio_middle, buttonSize, sec, () {}),
                    Note_AB(ratio_big, buttonSize, sec, () {
                      setState(() {
                        player.insertNoteScript(NoteScript(sec: sec, noteA: true));
                      });
                    }, () {
                      setState(() {
                        player.insertNoteScript(NoteScript(sec: sec, noteB: true));
                      });
                    }),
                    Note_Event(ratio_middle, buttonSize, sec, () {}),
                    Note_subTitle(ratio_small, sec, () {}),
                  ],
                );
              },
            ),
          ),
        ));
  }

  double getScrollpos(NotePlayer player) {
    double scrollMax = _ScrollController.position.maxScrollExtent;
    int noteMax = player.get_NoteScriptLength();
    int now = player.get_PlayTime() + 100;
    double pos = scrollMax * now / noteMax;
    return pos;
  }

  Widget Note_sec(int ratio_sec, double buttonSize1, int sec, Null function()) {
    int time = BFCore().notePlayer.get_PlayTime();
    Color colorA = (sec < time) ? AppData().color.Note_after_Empty : AppData().color.Note_before_Empty;

    if (BFCore().notePlayer.get_PlayerState() == NotePlayerState.Play) {
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

  Expanded Note_AB(int ratio_big, double buttonSize, sec, Null functionA(), Null functionB()) {
    NoteScript? script = BFCore().notePlayer.get_NoteScript(sec);
    bool checkA = false;
    bool checkB = false;
    int time = BFCore().notePlayer.get_PlayTime();

    if (script != null) {
      if (script.noteA != null) checkA = script.noteA!;
      if (script.noteB != null) checkB = script.noteB!;
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
    return Expanded(
        flex: ratio_middle,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: buttonSize, child: ElevatedButton(child: Text("Event"), onPressed: function)),
              ],
            )));
  }

  Expanded Note_subTitle(int ratio_small, sec, Null function()) {
    return Expanded(
        flex: ratio_small,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(child: Text("SubTitle"), onPressed: function),
              ],
            )));
  }

  Widget Footer() {
    final player = BFCore().notePlayer;
    return Expanded(
        flex: ratio_Footer,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.lightBlueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(player.get_PlayTime_inFormat() + "   ms : " + player.get_PlayTime().toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        player.startTimer();
                      },
                      child: Text("Play")),
                  OutlinedButton(
                      onPressed: () {
                        player.pauseTimer();
                      },
                      child: Text("Pause")),
                  OutlinedButton(
                      onPressed: () {
                        player.stopTimer();
                      },
                      child: Text("Stop")),
                ],
              )
            ],
          ),
        ));
  }

  void update() {
    widget.timer = Timer.periodic(
      Duration(milliseconds: 200),
      (timer) => setState(() {}),
    );
  }
}
