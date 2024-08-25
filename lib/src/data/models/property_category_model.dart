import 'package:flutter/cupertino.dart';

class PropertyCategoryModel {
  String icon = "", title = "", description = "" ,type="";

  IconData iconData;

  PropertyCategoryModel(
      {required this.iconData,
        required this.type,
        required this.icon,
        required this.title,
        required this.description});
}
