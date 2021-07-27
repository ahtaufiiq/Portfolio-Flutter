import 'package:coba/screens/markdown.dart';
import 'package:coba/screens/notes.dart';
import 'package:coba/screens/notes2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Markdown(),
    );
  }
}
