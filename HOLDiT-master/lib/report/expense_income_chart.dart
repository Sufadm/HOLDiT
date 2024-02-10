import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:holdit/providers/month_picker_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../db/transactions_db/transaction_db_functions.dart';
import '../db/transactions_db/transaction_model.dart';

class ExpenseorIncomeProgressBar extends StatelessWidget {
  final bool isExpense;
  const ExpenseorIncomeProgressBar({required this.isExpense, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MonthPickerProvider>(
      builder: (context, monthPickerProvider, child) =>
          ValueListenableBuilder<List<TransactionModel>>(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext context,
            List<TransactionModel> expenseorIncomeTransactions, _) {
          var allExpenseOrIncome = expenseorIncomeTransactions
              .where((element) => element.isExpense == isExpense)
              .where((element) =>
                  element.date.month ==
                      monthPickerProvider.selectedMonth!.month &&
                  element.date.year == monthPickerProvider.selectedMonth!.year)
              .toList();

          // Group the transactions by category name
          var groupedExpenseorIncome = groupBy<TransactionModel, String>(
              allExpenseOrIncome,
              (expenseorIncome) => expenseorIncome.category!.name);

          // Convert the grouped data into a list of MapEntry objects
          var data = groupedExpenseorIncome.entries
              .map((entry) => MapEntry<String, double>(
                  entry.key,
                  entry.value.fold(
                      0,
                      (total, expenseOrIncome) =>
                          total + expenseOrIncome.amount)))
              .toList();
          String formattedDate =
              DateFormat('MMM-yyyy').format(monthPickerProvider.selectedMonth!);
          return data.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SfCircularChart(
                    title: ChartTitle(
                        text: "$formattedDate Report",
                        textStyle: const TextStyle(fontSize: 20)),
                    series: <CircularSeries>[
                      DoughnutSeries<MapEntry<String, double>, String>(
                        explode: true,
                        explodeAll: true,
                        innerRadius: "50%",
                        dataSource: data,
                        xValueMapper: (entry, _) => entry.key,
                        yValueMapper: (entry, _) => entry.value,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                        pointColorMapper: (entry, _) {
                          // Get the category color from the groupedExpenseorIncome map
                          var category = entry.key;
                          var categoryTransactions =
                              groupedExpenseorIncome[category]!;
                          var categoryColor =
                              categoryTransactions[0].category!.color;
                          return categoryColor;
                        },
                      )
                    ],
                    legend: Legend(
                        isVisible: true,
                        iconHeight: 20,
                        position: LegendPosition.bottom,
                        orientation: LegendItemOrientation.vertical),
                  ),
                )
              : Column(
                  children: [
                    Image.asset(
                      "assets/Empty_report.gif",
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Text("No Transaction Has Added For $formattedDate")
                  ],
                );
        },
      ),
    );
  }
}
