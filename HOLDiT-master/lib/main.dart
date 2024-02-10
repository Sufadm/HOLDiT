import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:holdit/providers/add_item_screen_provider.dart';
import 'package:holdit/providers/add_new_category_provider.dart';
import 'package:holdit/providers/bottom_nav_bar_provider.dart';
import 'package:holdit/providers/category_selection_dropdown_provider.dart';
import 'package:holdit/providers/month_picker_provider.dart';
import 'package:holdit/providers/radio_button_provider.dart';
import 'package:holdit/providers/search_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash/splash_screen.dart';
import 'db/category_db/category_db_functions.dart';
import 'db/category_db/category_db_model.dart';
import 'db/transactions_db/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(IconDataAdapter());
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('predefCategoryCalled')) {
    CategoryDB.instance.predefCategory();
    await prefs.setBool('predefCategoryCalled', true);
  }

  runApp(const Holdit());
}

class Holdit extends StatelessWidget {
  const Holdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddNewcategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonthPickerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddItemsScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategorySelectionDropdownProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RadioButtonsProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          home: const SplashScreen()),
    );
  }
}
