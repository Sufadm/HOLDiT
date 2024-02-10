import 'package:flutter/material.dart';

class CategorySelectionDropdownProvider extends ChangeNotifier {
  List<DropdownMenuItem<String>> incomeCatitemsList = [];
  List<DropdownMenuItem<String>> expenseCatitemsList = [];
  String? selectedExpenseItem;
  String? selectedIncomeItem;


  void addToIncomeCategoryList(List<DropdownMenuItem<String>> catItems) {
    incomeCatitemsList = catItems;
    notifyListeners();
  }
  void addToExpenseCategoryList(List<DropdownMenuItem<String>> catItems) {
    expenseCatitemsList = catItems;
    notifyListeners();
  }
  void selectExpenseCategory(String value)
  {
    selectedExpenseItem=value;
    notifyListeners();
  }
    void selectIncomeCategory(String value)
  {
    selectedIncomeItem=value;
    notifyListeners();
  }
}
