import 'package:flutter/material.dart';
import 'package:SearchIt/pages/homepage.dart';

Widget floatingButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      if (status == 0) {}
      if (status == 1) {
        //Insert route for edit_item but new item, with boolean
      }
    },
    tooltip: 'addItem',
    child: Icon(Icons.add),
  );
}
