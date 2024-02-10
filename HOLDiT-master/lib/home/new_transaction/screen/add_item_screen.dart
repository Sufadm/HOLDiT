import 'package:flutter/material.dart';
import 'package:holdit/providers/add_item_screen_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../add_transaction.dart';

List<String> selectExpenseOrIncome = <String>['Expense', 'Income'];

class AddItemsScreen extends StatefulWidget {
  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  @override
  void initState() {
    context.read<AddItemsScreenProvider>().selectedDate = DateTime.now();
    context.read<AddItemsScreenProvider>().selectedValue = 'Expense';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        title: const Text("Add items",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  Consumer<AddItemsScreenProvider>(
                    builder: (context, datePickerProvider, child) => SizedBox(
                      width: 200,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          datePickerProvider.datePicker(context);
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Center(
                              child: Icon(
                            Icons.edit_calendar_outlined,
                            size: 20,
                            color: Color.fromARGB(255, 136, 128, 128),
                          )),
                        ),
                        label: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Text(
                            DateFormat("dd,MMMM,yyyy")
                                .format(datePickerProvider.selectedDate!),
                            style: const TextStyle(color: Colors.black),
                          ),
                        )),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xDFE0E0E0),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Consumer<AddItemsScreenProvider>(
                    builder: (context, categoryTypeProvider, child) =>
                        DropdownButtonFormField(
                      value: categoryTypeProvider.selectedValue,
                      items: selectExpenseOrIncome.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        categoryTypeProvider.categoryTypeDropdown(value!);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    child: (context
                                .watch<AddItemsScreenProvider>()
                                .selectedValue ==
                            "Expense")
                        ? AddTransaction(isExpense: true)
                        : AddTransaction(isExpense: false),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
