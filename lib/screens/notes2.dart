import 'package:coba/widgets/text_controller.dart';
import 'package:flutter/material.dart';

class CodeEditor extends StatefulWidget {
  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  late RichTextController _controller;
  Map<RegExp, TextStyle> patternUser = {
    RegExp(r"\B@[a-zA-Z0-9]+\b"):
        TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)
  };

  @override
  void initState() {
    _controller = RichTextController(
      patternMap: patternUser,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextField(
          controller: _controller,
        ),
      ),
    );
  }
}
