import 'package:flutter/material.dart';

class RadioButtonsProvider extends ChangeNotifier {
  int? radioVal;

  void changeRadioValue(int? value) {
    radioVal = value;
    notifyListeners();
  }
}
