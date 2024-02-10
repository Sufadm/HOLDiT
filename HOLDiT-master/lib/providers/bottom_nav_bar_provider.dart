import 'package:flutter/Material.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  int selectedIndex = 1;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
