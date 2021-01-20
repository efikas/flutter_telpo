import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_telpo/flutter_telpo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            ListTile(
              leading: Icon(Icons.bluetooth_searching),
              trailing:
              IconButton(icon: Icon(Icons.print_rounded),),
              title: Text("Default Printer"),
              onTap: (){
                TestPrintables().printThroughUsbPrinter();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TestPrintables {
  FlutterTelpo _printer = new FlutterTelpo();
  bool _isConnected = false;


  printThroughUsbPrinter() {
    try {
      _printer.connect();
      _printer.isConnected().then((bool isConneted) {
        if (isConneted) {
          List<dynamic> _printables = [];

          _printables.addAll([
            PrintRow(
              text: "BAUCHI STATE INTERNAL REVENUE SERVICE",
              fontSize: 2,
              position: 1,
            ),
            PrintRow(
                text: "*****************************",
                fontSize: 1,
                position: 1),
          ]);
          _printables.addAll([
            PrintRow(text: "TESTING", fontSize: 2, position: 1),
            PrintRow(
                text: "*****************************",
                fontSize: 1,
                position: 0),
          ]);
          _printables.add(WalkPaper(step: 10));
          _printer.print(_printables.toList());
        }
      });
    }
    on PlatformException catch (e) {
      print(e);
    }
  }
}

