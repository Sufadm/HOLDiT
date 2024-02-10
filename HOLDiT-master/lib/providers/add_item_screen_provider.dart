import 'package:flutter/material.dart';

class AddItemsScreenProvider extends ChangeNotifier {
  DateTime? selectedDate;
  String? selectedValue;
  


  void  datePicker(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((date) {
      if (date != null) {
        selectedDate = date;
        notifyListeners();
      }
    });
  }


  void categoryTypeDropdown(String value)
  {
    selectedValue=value;
    notifyListeners();
  }
}
