import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:holdit/providers/search_screen_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../db/transactions_db/transaction_model.dart';
import 'update_transaction.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    context.read<SearchScreenProvider>().outputList =
        context.read<SearchScreenProvider>().totalTransactionList;
    context.read<SearchScreenProvider>().selectedTransactionType = 'All';
    context.read<SearchScreenProvider>().outputList = [];
    context.read<SearchScreenProvider>().query = "";
    context.read<SearchScreenProvider>().startDate = null;
    context.read<SearchScreenProvider>().endDate = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        title: const Text("Search",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xDFE0E0E0),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  height: 10,
                  alignedDropdown: true,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    iconSize: 20,
                    value: context
                        .watch<SearchScreenProvider>()
                        .selectedTransactionType,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: context
                        .watch<SearchScreenProvider>()
                        .searchTransactionTypeItems
                        .map(
                      (String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      context
                          .read<SearchScreenProvider>()
                          .onTransactionTypeChanged(newValue!);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                color: const Color.fromARGB(255, 231, 231, 231),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for transactions',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => context
                          .read<SearchScreenProvider>()
                          .searchQuerychanged(value),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 2)),
                onPressed: () {
                  showCustomDateRangePicker(
                    context,
                    dismissible: true,
                    minimumDate: DateTime(2010),
                    maximumDate: DateTime.now(),
                    endDate: context.read<SearchScreenProvider>().endDate,
                    startDate: context.read<SearchScreenProvider>().startDate,
                    onApplyClick: (start, end) {
                      context
                          .read<SearchScreenProvider>()
                          .dateRangePicker(start, end);
                    },
                    onCancelClick: () {
                      context.read<SearchScreenProvider>().cancelDateRange();
                    },
                  );
                },
                child: context.watch<SearchScreenProvider>().startDate == null
                    ? const Text(
                        "Choose a date range",
                        style: TextStyle(color: Colors.grey),
                      )
                    : Text(
                        style: const TextStyle(color: Colors.grey),
                        '${context.watch<SearchScreenProvider>().startDate != null ? DateFormat("dd/MMM/yyyy").format(context.watch<SearchScreenProvider>().startDate!) : '-'} - ${context.watch<SearchScreenProvider>().endDate != null ? DateFormat("dd/MMM/yyyy").format(context.watch<SearchScreenProvider>().endDate!) : '-'}',
                      ),
              ),
              Consumer<SearchScreenProvider>(
                builder: (context, selectedTypeProvider, _) {
                  final selectedType =
                      selectedTypeProvider.selectedTransactionType;
                  List<TransactionModel> filteredList = selectedTypeProvider
                      .totalTransactionList
                      .where((element) {
                    bool matchesQuery = element.category!.name
                            .trim()
                            .toLowerCase()
                            .contains(context
                                .watch<SearchScreenProvider>()
                                .query
                                .trim()
                                .toLowerCase()) ||
                        element.description.trim().toLowerCase().contains(
                            context
                                .watch<SearchScreenProvider>()
                                .query
                                .trim()
                                .toLowerCase());

                    if (selectedType ==
                        selectedTypeProvider.searchTransactionTypeItems[0]) {
                      return matchesQuery;
                    } else if (selectedType ==
                        selectedTypeProvider.searchTransactionTypeItems[1]) {
                      return element.isExpense == true && matchesQuery;
                    } else {
                      return element.isExpense == false && matchesQuery;
                    }
                  }).toList();

                  if (context.watch<SearchScreenProvider>().startDate != null &&
                      context.watch<SearchScreenProvider>().endDate != null) {
                    filteredList = filteredList
                        .where(
                          (element) =>
                              element.date.isBefore(
                                context
                                    .watch<SearchScreenProvider>()
                                    .endDate!
                                    .add(
                                      const Duration(days: 1),
                                    ),
                              ) &&
                              element.date.isAfter(
                                context
                                    .watch<SearchScreenProvider>()
                                    .startDate!
                                    .subtract(
                                      const Duration(days: 1),
                                    ),
                              ),
                        )
                        .toList();
                  }
                  selectedTypeProvider.outputList = filteredList;
                  if (selectedTypeProvider.outputList.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/search_result-null.gif",
                            height: MediaQuery.of(context).size.width * 0.6,
                          ),
                          const Text("No data found")
                        ],
                      ),
                    );
                  } else {
                    return Consumer<SearchScreenProvider>(
                      builder: (context, newListProvider, _) {
                        final newList = newListProvider.outputList;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: newList.length,
                          itemBuilder: (context, index) {
                            TransactionModel value = newList[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                        id: value.id,
                                        selectedValue: value.isExpense
                                            ? "Expense"
                                            : "Income",
                                        selectedDate: value.date,
                                        selectedCategory: value.category!,
                                        selectedAmount: value.amount,
                                        selectedDescription: value.description),
                                  ),
                                );
                              },
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: value.category!.color,
                                  ),
                                  Positioned.fill(
                                      child: Icon(value.category!.icon))
                                ],
                              ),
                              title: Text(value.description),
                              subtitle: Text(value.category!.name),
                              trailing: value.isExpense
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "- ₹ ${value.amount}",
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                        Text(DateFormat("dd/MMM/yyyy")
                                            .format(value.date))
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("+ ₹ ${value.amount}"),
                                        Text(DateFormat("dd/MMM/yyyy")
                                            .format(value.date))
                                      ],
                                    ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
