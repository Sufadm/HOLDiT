import 'package:flutter/material.dart';

class StockCatitem extends StatelessWidget {
  final Color catcolour;
  final IconData caticon;
  final String catname;
  const StockCatitem({
    super.key,
    required this.catcolour,
    required this.caticon,
    required this.catname,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(children: [
          CircleAvatar(
            backgroundColor: catcolour,
          ),
          Positioned.fill(
            child: Icon(
              caticon,
              color: const Color.fromARGB(123, 0, 0, 0),
            ),
          ),
        ]),
        const SizedBox(
          width: 20,
        ),
        Text(catname),
      ],
    );
  }
}
