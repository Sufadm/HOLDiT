
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'category_db_model.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future <void> deleteCategory(String categoryID);
  Future <void> predefCategory();
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB.internal();
  static CategoryDB instance=CategoryDB.internal();
  factory CategoryDB(){
    return instance;
  }


  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id,value);
    
    
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }
  
  @override
  Future<void> deleteCategory(String categoryID)async {
    final categoryDB= await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    categoryDB.delete(categoryID);
  }
  
  @override
  Future<void> predefCategory()async {
  await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  final category1 = CategoryModel(
    id: "1",
    name: 'Grocery',
    icon: Icons.local_grocery_store,
    color: const Color.fromARGB(255, 187, 204, 125),
    isExpense: true,
  );
  final category2 = CategoryModel(
    id: "2",
    name: 'Fuel',
    icon: Icons.local_gas_station,
    color: const Color.fromARGB(255, 221, 204, 126),
    isExpense: true,
  );
  final category3 = CategoryModel(
    id: "3",
    name: 'Food',
    icon: Icons.food_bank_outlined,
    color: const Color.fromARGB(255, 145, 203, 250),
    isExpense: true,
  );
  final category4 = CategoryModel(
    id: "4",
    name: 'Travel',
    icon: Icons.travel_explore_outlined,
    color: const Color.fromARGB(255, 231, 168, 240),
    isExpense: true,
  );
  final category5 = CategoryModel(
    id: "5",
    name: 'Electronics',
    icon: Icons.tv_outlined,
    color: const Color.fromARGB(255, 250, 192, 145),
    isExpense: true,
  );
  final category6 = CategoryModel(
    id: "6",
    name: 'Health',
    icon: Icons.health_and_safety_outlined,
    color: const Color.fromARGB(255, 247, 165, 165),
    isExpense: true,
  );
  final category7 = CategoryModel(
    id: "7",
    name: 'Liqour',
    icon: Icons.liquor_outlined,
    color: const Color.fromARGB(255, 167, 219, 221),
    isExpense: true,
  );
  final category8 = CategoryModel(
    id: "8",
    name: 'Laundry',
    icon: Icons.local_laundry_service_outlined,
    color: const Color.fromARGB(255, 196, 140, 140),
    isExpense: true,
  );
  final category9 = CategoryModel(
    id: "9",
    name: 'Restaurant',
    icon: Icons.restaurant_outlined,
    color: const Color.fromARGB(255, 178, 208, 253),
    isExpense: true,
  );
  final category10 = CategoryModel(
    id: "10",
    name: 'Gift',
    icon: Icons.card_giftcard_outlined,
    color: const Color.fromARGB(255, 90, 201, 182),
    isExpense: true,
  );


final category11 = CategoryModel(
    id: "11",
    name: 'Salary',
    icon: Icons.money_outlined,
    color: const Color.fromARGB(255, 117, 122, 99),
    isExpense: false,
  );
  final category12 = CategoryModel(
    id: "12",
    name: 'Gifts',
    icon: Icons.card_giftcard_sharp,
    color: const Color.fromARGB(255, 78, 108, 112),
    isExpense: false,
  );
  final category13 = CategoryModel(
    id: "13",
    name: 'Wages',
    icon: Icons.heat_pump_rounded,
    color: const Color.fromARGB(255, 145, 203, 250),
    isExpense: false,
  );
  final category14 = CategoryModel(
    id: "14",
    name: 'Interests',
    icon: Icons.account_balance_outlined,
    color: const Color.fromARGB(255, 94, 74, 97),
    isExpense: false,
  );
  final category15 = CategoryModel(
    id: "15",
    name: 'Allowance',
    icon: Icons.attach_money_outlined,
    color: const Color.fromARGB(255, 106, 126, 103),
    isExpense: false,
  );

  


  final categoryDB = CategoryDB();
  await categoryDB.insertCategory(category1);
  await categoryDB.insertCategory(category2);
  await categoryDB.insertCategory(category3);
  await categoryDB.insertCategory(category4);
  await categoryDB.insertCategory(category5);
  await categoryDB.insertCategory(category6);
  await categoryDB.insertCategory(category7);
  await categoryDB.insertCategory(category8);
  await categoryDB.insertCategory(category9);
  await categoryDB.insertCategory(category10);
  await categoryDB.insertCategory(category11);
  await categoryDB.insertCategory(category12);
  await categoryDB.insertCategory(category13);
  await categoryDB.insertCategory(category14);
  await categoryDB.insertCategory(category15);
  }
}

