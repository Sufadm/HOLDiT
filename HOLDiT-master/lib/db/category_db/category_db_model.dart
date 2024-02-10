
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_db_model.g.dart';



@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final IconData icon;
  
  @HiveField(3)
  final Color color;

  @HiveField(4)
  final bool isDeleted;

  @HiveField(5)
 final bool isExpense;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.isDeleted = false,
    required this.isExpense,
  });
}








class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final int typeId = 3;

  @override
  IconData read(BinaryReader reader) {
    final codePoint = reader.readInt();
    return IconData(codePoint, fontFamily: 'MaterialIcons');
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    writer.writeInt(obj.codePoint);
  }
}

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 2;

  @override
  Color read(BinaryReader reader) {
    final value = reader.readInt();
    return Color(value);
  }
  
  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }
}

