import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_beatfighter/package_beatfighter.dart';

class TestScreen extends StatefulWidget {
  TestScreen({super.key});

  late Timer timer;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int ratio_Header = 1;
  int ratio_Body = 7;
  int ratio_Footer = 3;

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
    return Expanded(
        flex: ratio_Body,
        child: Container(
          padding: EdgeInsets.all(3),
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.greenAccent,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(title: Text("$index"),);
            },),
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
              Text("Time : ${BFCore().notePlayer.Timertime()}"),
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
