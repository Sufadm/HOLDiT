import 'package:flutter/material.dart';
import '../common_widgets/month_picker.dart';
import 'radio_buttons.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Statistics",
              style: TextStyle(
                  color: Color.fromARGB(255, 71, 69, 69),
                  fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MonthPicker(),
              RadioButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
