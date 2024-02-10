import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("About",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("HOLDiT v1.0.1"),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/logo.png",
              height: 100,
            ),
            const Text(
              "Created by Sufad M",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
