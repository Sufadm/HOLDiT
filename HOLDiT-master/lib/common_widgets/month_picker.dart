import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/month_picker_provider.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({super.key});

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  @override
  void initState() {
    context.read<MonthPickerProvider>().selectedMonth = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MonthPickerProvider>(
      builder: (context, monthPickerProvider, child) => SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: OutlinedButton.icon(
            onPressed: () {
              monthPickerProvider.monthPicker(context);
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Center(
                  child: Icon(
                Icons.calendar_today_rounded,
                size: 18,
                color: Color.fromARGB(255, 136, 128, 128),
              )),
            ),
            label: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Text(
                DateFormat("MMM,yyyy")
                    .format(monthPickerProvider.selectedMonth!),
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
    );
  }
}
