import 'package:example_flutter/HomePage.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: new HomePage(),
      debugShowCheckedModeBanner: false
    );
  }
}
