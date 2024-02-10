// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';
import '../providers/bottom_nav_bar_provider.dart';
import '../report/report.dart';
import '../settings/settings.dart';

class ThreeInOne extends StatelessWidget {
   ThreeInOne({
    super.key,
  });

  List<Widget> widgetOptions = [
    const ReportScreen(),
    const HomeScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
   int selectedIndex= Provider.of<BottomNavigationBarProvider>(context).selectedIndex;
    return SafeArea(
      child: Scaffold(
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 211, 207, 207),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline),
                activeIcon: Icon(Icons.pie_chart),
                label: "Report",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 119, 116, 116),
            onTap: Provider.of<BottomNavigationBarProvider>(context,listen: false).onItemTapped,
          ),
        ),
      ),
    );
  }
}
