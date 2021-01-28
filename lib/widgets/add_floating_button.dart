import 'package:SearchIt/data/objects.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/pages/homepage.dart';

Widget floatingButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      if (status == 0) {
        Navigator.pushNamed(context, '/edit_home');
      }
      if (status == 1) {
        itemToEdit = Item.empty();
        choice = false;
        Navigator.pushNamed(context, '/edit_item');
      }
    },
    tooltip: 'addItem',
    child: Icon(Icons.add),
  );
}
