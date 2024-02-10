import 'package:flutter/material.dart';
import 'package:holdit/providers/radio_button_provider.dart';
import 'package:provider/provider.dart';

import 'all_transaction_chart.dart';
import 'expense_income_chart.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});
  @override
  State<RadioButtons> createState() => RadioButtonsState();
}

class RadioButtonsState extends State<RadioButtons> {
  @override
  void initState() {
    context.read<RadioButtonsProvider>().radioVal = 1;
    super.initState();
  }

  Widget? _buildChild() {
    if (context.watch<RadioButtonsProvider>().radioVal == 1) {
      return AllTransactionsProgressBar();
    } else if (context.watch<RadioButtonsProvider>().radioVal == 2) {
      return const ExpenseorIncomeProgressBar(
        isExpense: true,
      );
    } else {
      return const ExpenseorIncomeProgressBar(
        isExpense: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Consumer<RadioButtonsProvider>(
            builder: (context, radiobuttonProvider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: const Color.fromARGB(255, 102, 97, 97),
                    value: 1,
                    groupValue: radiobuttonProvider.radioVal,
                    onChanged: (value) {
                      radiobuttonProvider.changeRadioValue(value);
                    }),
                const Text("All",
                    style: TextStyle(color: Color.fromARGB(255, 80, 76, 76))),
                const Spacer(),
                Radio(
                    activeColor: const Color.fromARGB(255, 102, 97, 97),
                    value: 2,
                    groupValue: radiobuttonProvider.radioVal,
                    onChanged: (value) {
                      radiobuttonProvider.changeRadioValue(value);
                    }),
                const Text(
                  "Expense",
                  style: TextStyle(color: Color.fromARGB(255, 80, 76, 76)),
                ),
                const Spacer(),
                Radio(
                    activeColor: const Color.fromARGB(255, 102, 97, 97),
                    value: 3,
                    groupValue: radiobuttonProvider.radioVal,
                    onChanged: (value) {
                      radiobuttonProvider.changeRadioValue(value);
                    }),
                const Text("Income",
                    style: TextStyle(color: Color.fromARGB(255, 80, 76, 76))),
              ],
            ),
          ),
          Container(
            child: _buildChild(),
          )
        ],
      ),
    );
  }
}
