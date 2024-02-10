// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common_widgets/category_selection_Dropdown.dart';
import '../db/category_db/category_db_model.dart';
import '../db/transactions_db/transaction_db_functions.dart';
import '../db/transactions_db/transaction_model.dart';
import '../providers/add_item_screen_provider.dart';
import 'new_transaction/add_transaction.dart';

class UpdateScreen extends StatefulWidget {
  List<String> selectExpenseOrIncome = <String>['Expense', 'Income'];
  String? id;
  String selectedValue;
  DateTime selectedDate;
  CategoryModel selectedCategory;
  double selectedAmount;
  String selectedDescription;
  UpdateScreen(
      {required this.id,
      required this.selectedValue,
      required this.selectedDate,
      required this.selectedCategory,
      required this.selectedAmount,
      required this.selectedDescription,
      super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController amountTextController;
  late TextEditingController descriptionTextController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    amountTextController =
        TextEditingController(text: widget.selectedAmount.toString());
    descriptionTextController =
        TextEditingController(text: widget.selectedDescription);
    context.read<AddItemsScreenProvider>().selectedDate = widget.selectedDate;
    context.read<AddItemsScreenProvider>().selectedValue = widget.selectedValue;
    
  }

  @override
  void dispose() {
    amountTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        title: const Text("Update Transaction",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text(
                        'Do you sure want to delete this Transaction?',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            TransactionDB.instance
                                .deleteTransaction(widget.id!);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Transaction Deleted"),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ));
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete_outline_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Consumer<AddItemsScreenProvider>(
                    builder: (context, datePickerProvider, child) =>
                        OutlinedButton.icon(
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
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                  ),
                ),
                Consumer<AddItemsScreenProvider>(
                  builder: (context, categoryTypeProvider, child) =>
                      DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          items: widget.selectExpenseOrIncome.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          value: categoryTypeProvider.selectedValue,
                          onChanged: (value) {
                            categoryTypeProvider.categoryTypeDropdown(value!);
                          }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    context.watch<AddItemsScreenProvider>().selectedValue ==
                            'Expense'
                        ? ExpenseCategoryDropDown()
                        : IncomeCategoryDropDown(),
                    Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            showCategoryDialog(context);
                          },
                          icon: const Icon(Icons.add_circle_outline_sharp),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: amountTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter an amount";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.currency_rupee),
                      border: OutlineInputBorder(),
                      labelText: "Enter Amount"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Description";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_color_text_rounded),
                      border: OutlineInputBorder(),
                      labelText: "Description"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      updateTransaction();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Transaction Updated"),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Update"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateTransaction() async {
    widget.selectedAmount = double.parse(amountTextController.text);
    widget.selectedDescription = descriptionTextController.text;
    final model = TransactionModel(
        id: widget.id,
        date: context.read<AddItemsScreenProvider>().selectedDate!,
        isExpense:
            context.read<AddItemsScreenProvider>().selectedValue == "Expense"
                ? true
                : false,
        category: selectedCategoryModel,
        amount: widget.selectedAmount,
        description: widget.selectedDescription);

    TransactionDB.instance.updateTransaction(model);
    TransactionDB.instance.refresh();
  }
}
