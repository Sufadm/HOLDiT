import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:holdit/providers/add_new_category_provider.dart';
import 'package:provider/provider.dart';

import '../db/category_db/category_db_functions.dart';
import '../db/category_db/category_db_model.dart';

class AddCategoryDialogue extends StatefulWidget {
  AddCategoryDialogue({Key? key}) : super(key: key);

  @override
  State<AddCategoryDialogue> createState() => _AddCategoryDialogueState();
}

class _AddCategoryDialogueState extends State<AddCategoryDialogue> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<AddNewcategoryProvider>().itemName = "";
    context.read<AddNewcategoryProvider>().radioVal = 1;
    context.read<AddNewcategoryProvider>().selectedColor = Colors.blue;
    context.read<AddNewcategoryProvider>().selectedIcon =
        Icons.gas_meter_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text('Add New Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<AddNewcategoryProvider>(
              builder: (context, radioProvider, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      activeColor: const Color.fromARGB(255, 102, 97, 97),
                      value: 1,
                      groupValue: radioProvider.radioVal,
                      onChanged: (value) {
                        radioProvider.changeRadioValue(value);
                      }),
                  const Text(
                    "Expense",
                    style: TextStyle(color: Color.fromARGB(255, 80, 76, 76)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Radio(
                      activeColor: const Color.fromARGB(255, 102, 97, 97),
                      value: 2,
                      groupValue: radioProvider.radioVal,
                      onChanged: (value) {
                        radioProvider.changeRadioValue(value);
                      }),
                  const Text("Income",
                      style: TextStyle(color: Color.fromARGB(255, 80, 76, 76))),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Select Icon",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Consumer<AddNewcategoryProvider>(
                    builder: (context, iconProvider, child) =>
                        DropdownButtonFormField<IconData>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: iconProvider.selectedIcon,
                      onChanged: (IconData? newValue) {
                        iconProvider.changeIcon(newValue);
                      },
                      items: <IconData>[
                        Icons.gas_meter_outlined,
                        Icons.work_outlined,
                        Icons.abc,
                        Icons.ac_unit,
                        Icons.account_balance_outlined,
                        Icons.zoom_out_map_sharp,
                        Icons.home_max_outlined,
                        Icons.build,
                        Icons.local_post_office_outlined,
                        Icons.star_outline_sharp,
                        Icons.account_tree_outlined,
                        Icons.wind_power_sharp,
                        Icons.done_outline_sharp,
                        Icons.emoji_emotions_outlined
                      ].map<DropdownMenuItem<IconData>>((IconData value) {
                        return DropdownMenuItem<IconData>(
                          value: value,
                          child: Icon(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pick Colour",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Consumer<AddNewcategoryProvider>(
                  builder: (context, colorProvider, child) => GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: colorProvider.selectedColor!,
                                onColorChanged: (color) {
                                  colorProvider.changeColor(color);
                                },
                                pickerAreaHeightPercent: 0.5,
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color.fromARGB(255, 155, 146, 146),
                      child: CircleAvatar(
                        backgroundColor: colorProvider.selectedColor,
                        radius: 28,
                        child: Icon(
                          context.watch<AddNewcategoryProvider>().selectedIcon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Consumer<AddNewcategoryProvider>(
              builder: (context, itemNameProvider, child) => TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Category Name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Item Name', border: OutlineInputBorder()),
                onChanged: (value) {
                  itemNameProvider.changeItemName(value);
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final category = CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: context.read<AddNewcategoryProvider>().itemName!,
                  icon: context.read<AddNewcategoryProvider>().selectedIcon!,
                  color: context.read<AddNewcategoryProvider>().selectedColor!,
                  isExpense:
                      context.read<AddNewcategoryProvider>().radioVal == 1,
                );
                CategoryDB.instance.insertCategory(category);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("New category Added"),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
