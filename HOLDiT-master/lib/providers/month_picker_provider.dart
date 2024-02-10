import 'package:flutter/widgets.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';

class MonthPickerProvider extends ChangeNotifier {
  DateTime? selectedMonth;
  void monthPicker(BuildContext context) async {
    await showMonthPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((date) {
      if (date != null) {
        selectedMonth = date;
        notifyListeners();
      }
    });
  }
}
