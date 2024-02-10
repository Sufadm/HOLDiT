import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:holdit/bottom_navbar/three_in_one.dart';
import 'package:timer_button_fork/timer_button_fork.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';
import '../db/category_db/category_db_functions.dart';
import 'about.dart';
import 'faq.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future share() async {
    await FlutterShare.share(
        title: ' HOLDiT',
        text: 'HOLDiT : Balancing your money',
        linkUrl:
            'https://play.google.com/store/apps/details?id=in.itsarshadh.holdit&pcampaignid=web_share'
            '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Settings",
              style: TextStyle(
                  color: Color.fromARGB(255, 71, 69, 69),
                  fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FaQ()),
                );
              },
              leading: const Icon(Icons.quiz_outlined),
              title: const Text("Frequently Asked Questions"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
              leading: const Icon(Icons.info_outline),
              title: const Text("About"),
            ),
            ListTile(
              onTap: (() async {
                const url = 'mailto:sufadzan1@gmail.com';
                Uri uri = Uri.parse(url);
                await launchUrl(uri);
              }),
              leading: const Icon(Icons.mail_outline_rounded),
              title: const Text("Contact Us"),
            ),
            ListTile(
              onTap: () {
                share();
              },
              leading: const Icon(Icons.share_sharp),
              title: const Text("Share HOLDiT"),
            ),
            ListTile(
              onTap: () {
                _showDeleteConfirmationDialog(context);
              },
              leading: const Icon(Icons.clear_all_outlined),
              title: const Text("Clear HOLDiT data"),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  const Text("Clear?!"),
                  Image.asset(
                    "assets/Warning.gif",
                    height: MediaQuery.of(context).size.width * 0.3,
                  ),
                ],
              ),
              content: const Text(
                'This will remove all user Data and this action cannot be undone',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  child: const Text(
                    'No',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TimerButton(
                  buttonType: ButtonType.ElevatedButton,
                  label: "Yes",
                  activeTextStyle: const TextStyle(color: Colors.white),
                  timeOutInSeconds: 3,
                  onPressed: () async {
                    await Hive.deleteFromDisk();
                    dataCleared(context);
                    CategoryDB.instance.predefCategory();
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}

Future<void> dataCleared(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              "assets/Erase.gif",
            )),
      );
    },
  );
  await Future.delayed(const Duration(seconds: 2));
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Center(child: Text("All User Data Cleared")),
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  ));
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ThreeInOne()),
      ModalRoute.withName(''));
}
