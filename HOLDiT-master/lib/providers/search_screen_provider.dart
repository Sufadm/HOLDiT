import 'package:flutter/material.dart';

import '../db/transactions_db/transaction_db_functions.dart';
import '../db/transactions_db/transaction_model.dart';

class SearchScreenProvider extends ChangeNotifier {
  
  List<String> searchTransactionTypeItems = ["All", "Expenses", "Income"];
  DateTime? startDate;
  DateTime? endDate;
  List<TransactionModel> totalTransactionList =
      TransactionDB.instance.transactionListNotifier.value;
  String selectedTransactionType = 'All';
  List<TransactionModel> outputList = [];
  String query = '';

  void onTransactionTypeChanged(String newValue)
  {
    selectedTransactionType=newValue;
    notifyListeners();
  }

  void dateRangePicker(DateTime start,DateTime end)
  {
    startDate=start;
    endDate=end;
    notifyListeners();
  }
  void cancelDateRange()
  {
    startDate=null;
    endDate=null;
    notifyListeners();
  }

  void searchQuerychanged(String newQuery)
  {
    query=newQuery;
    notifyListeners();
  }
}
