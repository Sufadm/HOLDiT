import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:holdit/home/update_transaction.dart';

import '../db/transactions_db/transaction_db_functions.dart';
import '../db/transactions_db/transaction_model.dart';
import 'new_transaction/screen/add_item_screen.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();

    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          // Sort the transactions by date in descending order
          newList.sort((latest, oldest) => oldest.date.compareTo(latest.date));

          // Group the transactions by date using a Map
          final groupedTransactions = groupBy(
              newList,
              (transaction) =>
                  DateFormat("dd MMM yyyy").format(transaction.date));
          if (newList.isEmpty) {
            return SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  Image.asset(
                    "assets/Empty box.png",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No transactions yet.Try to ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 128, 122, 122),
                            fontSize: 16),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddItemsScreen()),
                            );
                          },
                          child: const Text(
                            '"Add New"',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ))
                    ],
                  )
                ],
              )),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                // Get the group of transactions for the current date
                final group = groupedTransactions.values.elementAt(index);
                final dateString = groupedTransactions.keys.elementAt(index);
                final dateCard = Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: const Color.fromARGB(255, 235, 235, 235),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      dateString,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                );

                // Create a List of transaction Cards for the current group
                final transactionCards = group
                    .map((value) => Slidable(
                          key: Key(value.id!),
                          startActionPane:
                              ActionPane(motion: const ScrollMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
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
                                                .deleteTransaction(value.id!);
                                                ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Transaction Deleted"),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ));
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icons.delete_outline_sharp,
                            )
                          ]),
                          child: ListTile(
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
                                          selectedDescription:
                                              value.description)),
                                );
                              },
                              leading: Stack(children: [
                                CircleAvatar(
                                  backgroundColor: value.category!.color,
                                ),
                                Positioned.fill(
                                    child: Icon(value.category!.icon))
                              ]),
                              title: Text(value.description),
                              subtitle: Text(value.category!.name),
                              trailing: value.isExpense
                                  ? Text(
                                      "- ₹ ${value.amount}",
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : Text("+ ₹ ${value.amount}")),
                        ))
                    .toList();

                // Add the date Card and the transaction Cards to the ListView
                return Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(255, 194, 188, 188)),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      dateCard,
                      ...transactionCards,
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: groupedTransactions.length,
            );
          }
        });
  }
}
