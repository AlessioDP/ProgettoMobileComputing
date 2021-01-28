import 'package:SearchIt/data/database.dart';
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
        if (data.homes.isEmpty) {
          return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Need to create a home to add an item!'),
                            actions: <Widget>[
                              ElevatedButton(  
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Gotcha!')),  
                            ],
                          );
                        });
        } else {
          itemToEdit = Item.empty();
          choice = false;
          Navigator.pushNamed(context, '/edit_item');
        }
      }
    },
    tooltip: 'addItem',
    child: Icon(Icons.add),
  );
}
