import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:package_beatfighter/package_beatfighter.dart';
import 'package:solution_beatfighter/System/AppData.dart';

class TestScreen extends StatefulWidget {
  TestScreen({super.key});

  late Timer timer;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

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
    double buttonSize = AppData().utilScreen.Screen(context).width * 0.15;
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
              itemCount: 30,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            padding: EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(child: Text("$index"), onPressed: () {}),
                              ],
                            ))),
                    Expanded(
                        flex: 3,
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: buttonSize, child: ElevatedButton(child: Text("Bgm"), onPressed: () {})),
                              ],
                            ))),
                    Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            SizedBox(width: buttonSize, child: ElevatedButton(child: Text("Note A"), onPressed: () {})),
                            SizedBox(width: 10),
                            SizedBox(width: buttonSize, child: ElevatedButton(child: Text("Note B"), onPressed: () {})),
                          ]),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: buttonSize, child: ElevatedButton(child: Text("Event"), onPressed: () {})),
                              ],
                            ))),
                    Expanded(
                        flex: 2,
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(child: Text("Script"), onPressed: () {}),
                              ],
                            ))),
                  ],
                );
              },
            ),
          ),
        ));
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
              Text(player.get_PlayTime_inFormat()),
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
                        player.resetTimer();
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
