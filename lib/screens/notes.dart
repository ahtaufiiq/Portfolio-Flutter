import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Notes extends StatefulWidget {
  Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController _controller = TextEditingController();
  var text = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 8),
              child: TextField(
                controller: _controller,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            TextButton(
                onPressed: () {
                  var awal = _controller.text
                      .substring(0, _controller.selection.baseOffset);
                  var akhir = _controller.text.substring(
                      _controller.selection.extentOffset,
                      _controller.text.length);
                  var tengah =
                      '**${_controller.selection.textInside(_controller.text)}**';
                  _controller.text = awal + tengah + akhir;
                  _controller.selection =
                      TextSelection.fromPosition(TextPosition(offset: 4));
                  setState(() {
                    text = _controller.text;
                  });
                },
                child: Text("Testing")),
            MarkdownBody(data: text)
          ],
        ),
      ),
    );
  }
}
