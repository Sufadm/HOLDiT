import 'package:flutter/material.dart';

class AddNewcategoryProvider extends ChangeNotifier {
  int? radioVal;
  IconData? selectedIcon;
  Color? selectedColor;
  String? itemName = "";
  

  void changeRadioValue(int? value) {
    radioVal = value!;
    notifyListeners();
  }

  void changeIcon(IconData? icon) {
    selectedIcon = icon!;
    notifyListeners();
  }

  void changeColor(Color newColor) {
    selectedColor = newColor;
    notifyListeners();
  }

  void changeItemName(String newName) {
    itemName = newName;
    notifyListeners();
  }
}
