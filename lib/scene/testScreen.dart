import 'package:flutter/material.dart';

class testScreen extends StatefulWidget {
  const testScreen({super.key});

  @override
  State<testScreen> createState() => _testScreenState();
}

class _testScreenState extends State<testScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Select Menu"),
          ElevatedButton(onPressed: () { Navigator.pushNamed(context, "testEditor"); }, child: Text("Editor")),
          ElevatedButton(onPressed: () { Navigator.pushNamed(context, "testPlay"); }, child: Text("Play")),
          ElevatedButton(onPressed: () { }, child: Text("Config")),
        ],
      ),
    );
  }
}
