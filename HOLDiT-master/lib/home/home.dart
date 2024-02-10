import 'package:flutter/material.dart';
import 'package:holdit/home/new_transaction/screen/add_item_screen.dart';
import 'package:holdit/home/search_screen.dart';
import 'package:holdit/home/total_income_balance_card.dart';
import 'package:holdit/home/transactions_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(
                "assets/logo.png",
                height: 40,
              ),
              const Text(
                "HOLDiT",
                style: TextStyle(
                    color: Color.fromARGB(255, 71, 69, 69),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                  icon: const Icon(Icons.search,
                      size: 25, color: Color.fromARGB(255, 71, 69, 69))),
            )
          ],
        ),
        body: Stack(children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.35),
            child: const TransactionsList(),
          ),
          const IncomeExpenseCard()
        ]),
        floatingActionButton: FloatingActionButton.extended(
            isExtended: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemsScreen()),
              );
            },
            label: const Row(
              children: [
                Icon(Icons.add_circle_rounded),
                Text("Add New"),
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
