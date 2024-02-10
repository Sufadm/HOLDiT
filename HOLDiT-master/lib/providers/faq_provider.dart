import 'package:flutter/material.dart';

class FAQProvider extends ChangeNotifier {
  List<bool> isOpenList = [false, false, false];

  void toggleExpansionPanelList(int index, bool isOpen) {
    isOpenList[index] = !isOpen;
    notifyListeners();
  }
}
