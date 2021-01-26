import 'package:SearchIt/data/objects.dart';
import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  //Whit this boolean i can choose if i need to edit an Item or add a new item
  //True=>Edit Item
  //False=>New Item
  final bool choice;
  Item item;
  //aggiungere Item per poterlo modificare

  EditItem({Key key, this.choice, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleEdit = 'Edit this Item';
    final titleNew = 'Add new Item';

    return MaterialApp(
      title: choice ? titleEdit : titleNew,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: _EditItem(
        choice: choice,
      ),
    );
  }
}

class _EditItem extends StatefulWidget {
  final bool choice;

  _EditItem({this.choice});

  @override
  State<StatefulWidget> createState() => _EditItemState();
}

class _EditItemState extends State<_EditItem> {
  @override
  Widget build(BuildContext context) {
    return Form();
  }
}
