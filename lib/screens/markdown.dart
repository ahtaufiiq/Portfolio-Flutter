import 'dart:ui';
import 'package:flutter/material.dart';

final Color darkBlue = const Color.fromARGB(255, 18, 32, 47);

class Markdown extends StatefulWidget {
  const Markdown();
  _MarkdownState createState() => _MarkdownState();
}

class _MarkdownState extends State<Markdown> {
  final TextEditingController _controller = TextFieldFormatting({
    r"@.\w+": TextStyle(color: Colors.blue),
    'red': const TextStyle(
        color: Colors.red, decoration: TextDecoration.underline),
    'green': TextStyle(color: Colors.green),
    'purple': TextStyle(color: Colors.purple),
    r'_(.*?)\_': TextStyle(fontStyle: FontStyle.italic),
    '~(.*?)~': TextStyle(decoration: TextDecoration.lineThrough),
    r'\*(.*?)\*': TextStyle(fontWeight: FontWeight.bold),
    r'```(.*?)```': TextStyle(
      color: Colors.yellow,
      fontFeatures: [const FontFeature.tabularFigures()],
    ),
  });

  void formatText(_controller, pola) {
    var awal = _controller.text.substring(0, _controller.selection.baseOffset);
    var akhir = _controller.text
        .substring(_controller.selection.extentOffset, _controller.text.length);
    if (awal[awal.length - 1] == pola && akhir[akhir.length - 1] == pola) {
      awal = awal.substring(0, awal.length - 1);
      akhir = akhir.substring(1, akhir.length);
    } else {
      awal += pola;
      akhir = pola + akhir;
    }
    var tengah = '${_controller.selection.textInside(_controller.text)}';
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.selection.extentOffset));
    _controller.text = awal + tengah + akhir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 20),
              controller: _controller,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      formatText(_controller, "*");
                    },
                    child: Text("Bold")),
                TextButton(
                    onPressed: () {
                      formatText(_controller, "_");
                    },
                    child: Text("Italic")),
                TextButton(
                    onPressed: () {
                      formatText(_controller, "~");
                    },
                    child: Text("Coret")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldFormatting extends TextEditingController {
  final Map<String, TextStyle> map;
  final Pattern pattern;

  TextFieldFormatting(this.map)
      : pattern = RegExp(
            map.keys.map((key) {
              return key;
            }).join('|'),
            multiLine: true);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<InlineSpan> children = [];
    String patternMatched = "";
    String formatText;
    TextStyle myStyle;
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = (map[match[0]] ??
            map[map.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text)
                  ..forEach((element) {
                    if (element.group(0) == match[0]) {
                      patternMatched = e;
                      ret = true;
                    }
                  });
                return ret;
              },
            )])!;

        if (patternMatched == r"_(.*?)\_") {
          formatText = match[0]!.replaceAll("_", " ");
        } else if (patternMatched == r'\*(.*?)\*') {
          formatText = match[0]!.replaceAll("*", " ");
        } else if (patternMatched == "~(.*?)~") {
          formatText = match[0]!.replaceAll("~", " ");
        } else if (patternMatched == r'```(.*?)```') {
          formatText = match[0]!.replaceAll("```", "   ");
        } else {
          formatText = match[0]!;
        }
        children.add(TextSpan(
          text: formatText,
          style: style!.merge(myStyle),
        ));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}