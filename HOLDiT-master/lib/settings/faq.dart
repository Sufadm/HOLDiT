import 'package:flutter/material.dart';
// import 'package:holdit/providers/faq_provider.dart';
// import 'package:provider/provider.dart';

class FaQ extends StatelessWidget {
  const FaQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'FAQ',
          style: TextStyle(
              color: Color.fromARGB(255, 71, 69, 69),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          faq(
            title: 'What is HOLDiT?',
            description:
                'HOLDit is an application that helps you to keep an accurate record of your money inflow and outflow',
          ),
          faq(
              title: 'How HOLDiT helps me to balance my expense and income?',
              description:
                  'HOLDiT allows you to record your expenses and incomes as they occur. This provides an accurate record of how much money has been spent or earned and on what.\nYou can categorize your expenses and income based on the type of transaction (e.g. food, transportation, entertainment, etc.). This provides insight into spending/earning patterns and helps users identify areas where you can cut back.'),
          faq(
            title: 'What are the subscription charges to use this app?',
            description:
                'HOLDiT is completely free to use, with no hidden fees or in-app purchases and moreover No Ads at all.',
          )
        ]),
      ),
    );
  }
}

Widget faq({required String title, required String description}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(description)
      ],
    ),
  );
}
