import 'package:flutter/material.dart';
import 'Timetable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff235790),
        accentColor: Color(0xffE28F22),
        splashColor: Color(0xff588297),
      ),
      home: Timetable(),
    );
  }
}