
import 'package:hive_flutter/hive_flutter.dart';

import '../category_db/category_db_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 4)
class TransactionModel {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final bool isExpense;

  @HiveField(2)
  final CategoryModel? category;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final String description;

  @HiveField(5)
   String? id;

  TransactionModel({
    required this.id,
    required this.date,
    required this.isExpense,
    required this.category,
    required this.amount,
    required this.description,
  });
}
