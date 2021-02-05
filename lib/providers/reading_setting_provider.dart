import 'package:flutter/material.dart';

class ReadingSettingProvider extends ChangeNotifier {
  double fontSize = 24;
  String moqria;

  set setFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }
}
