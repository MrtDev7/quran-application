import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

InlineSpan aya({
  int number,
  String ayaId,
  String aya,
  Color color,
  double size,
  String fontFamily,
  Function longPress,
  String suratId,
}) {
  return TextSpan(text: null, children: [
    TextSpan(
      text: aya,
      recognizer: LongPressGestureRecognizer()..onLongPress = longPress,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: fontFamily,
      ),
    ),
    TextSpan(
      text: ' ﴿$number﴾ ',
      recognizer: LongPressGestureRecognizer()..onLongPress = longPress,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: fontFamily,
      ),
    ),
  ]);
}
