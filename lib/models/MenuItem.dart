import 'package:flutter/widgets.dart';
class MenuItem {
  final String title;
  final void Function(BuildContext) onSelected;

  MenuItem({required this.title, required this.onSelected});
}