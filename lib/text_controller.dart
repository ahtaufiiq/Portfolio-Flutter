import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextFieldColorizer extends TextEditingController {
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<InlineSpan> children = [];
    String? patternMatched;
    String? formatText;
    TextStyle? myStyle;
    final Map<String, TextStyle> map = {
      r"@\w+": TextStyle(color: Colors.blue),
      'red': const TextStyle(
          color: Colors.red, decoration: TextDecoration.underline),
      'green': TextStyle(color: Colors.green),
      'purple': TextStyle(color: Colors.purple),
      r'_(.*?)\_': TextStyle(fontStyle: FontStyle.italic),
      '~(.*?)~': TextStyle(
        decoration: TextDecoration.lineThrough,
      ),
      r'\*(.*?)\*': TextStyle(fontWeight: FontWeight.bold),
      r'```(.*?)```': TextStyle(color: Colors.yellow),
    };
    Pattern pattern = RegExp(
        map.keys.map((key) {
          return key;
        }).join('|'),
        multiLine: true);
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = map[match[0]] ??
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
            )];

        if (patternMatched == r"_(.*?)\_") {
          formatText = match[0]!.replaceAll("_", " ");
        } else if (patternMatched == r'\*(.*?)\*') {
          formatText = match[0]!.replaceAll("*", " ");
        } else if (patternMatched == "~(.*?)~") {
          formatText = match[0]!.replaceAll("~", " ");
        } else if (patternMatched == r'```(.*?)```') {
          formatText = match[0]!.replaceAll("```", "   ");
        } else {
          formatText = match[0];
        }
        children.add(TextSpan(
            text: formatText,
            style: style!.merge(myStyle),
            recognizer: TapGestureRecognizer()..onTap = launch));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }

  Future launch() async {
    print("teesto");
  }
}
