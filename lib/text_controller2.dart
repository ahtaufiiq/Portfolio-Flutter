import 'package:flutter/material.dart';

class ColoredTextEditingController extends TextEditingController {
  ColoredTextEditingController() : super();

  final regExp = RegExp(
    r'(?<string>"[^"]*")|(?<number>\b-?[0-9][0-9\.]*\b)|'
    r'(?<keyword>\btrue\b|\bfalse\b|\bnull\b)',
  );

  List<InlineSpan> _syntaxHighlight(String text, TextStyle style) {
    final TextStyle stringHighlightStyle =
        style.merge(const TextStyle(color: Colors.green));
    final TextStyle numberHighlightStyle =
        style.merge(const TextStyle(color: Colors.blue));
    final TextStyle keywordHighlightStyle =
        style.merge(const TextStyle(color: Colors.purple));
    final matches = regExp.allMatches(text).toList();
    final spans = <InlineSpan>[];

    var cursor = 0;
    for (final match in matches) {
      TextStyle style;
      if (match.namedGroup('string') != null) {
        style = stringHighlightStyle;
      } else if (match.namedGroup('number') != null) {
        style = numberHighlightStyle;
      } else {
        style = keywordHighlightStyle;
      }
      spans.add(TextSpan(text: text.substring(cursor, match.start)));
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: style,
        ),
      );
      cursor = match.end;
    }
    spans.add(TextSpan(text: text.substring(cursor, text.length)));
    return spans;
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(
        style: style,
        children: _syntaxHighlight(text, style!),
      );
    }
    final TextStyle composingStyle = style!.merge(
      const TextStyle(decoration: TextDecoration.underline),
    );
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(
            children: _syntaxHighlight(
                value.composing.textBefore(value.text), style)),
        TextSpan(
          style: composingStyle,
          children:
              _syntaxHighlight(value.composing.textInside(value.text), style),
        ),
        TextSpan(
            children:
                _syntaxHighlight(value.composing.textAfter(value.text), style)),
      ],
    );
  }
}
