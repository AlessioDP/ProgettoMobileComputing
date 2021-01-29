import 'package:SearchIt/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/constants.dart';
import 'package:SearchIt/data/database.dart';

bool choiceMaster;
Item itemMaster;

class EditItem extends StatelessWidget {
  final bool choice; //true -> edit // false -> new item
  final Item item;

  final String editTitle = 'Edit Item';
  final String newTitle = 'Create New Item';

  EditItem({Key key, this.choice, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    choiceMaster = choice;
    if (item == null) {
      itemMaster = Item.empty();
    } else {
      itemMaster = item;
    }
    String title;

    if (choice) {
      title = editTitle;
    } else {
      title = newTitle;
    }

    return Scaffold(
        body: _EditItem(
      title: title,
    ));
  }
}

class _EditItem extends StatefulWidget {
  final String title;
  _EditItem({this.title});

  @override
  _EditItemState createState() => _EditItemState(title: title);
}

class _EditItemState extends State<_EditItem> {
  String title;

  _EditItemState({this.title});
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> _homesNames = Home.getHomesNames();
    List<Home> _homes = data.homes;

    Home _home;

    if (choiceMaster) {
      _nameController.text = itemMaster.name;
      _descriptionController.text = itemMaster.description;
      _home =
          _homes.where((element) => element.name == itemMaster.homeName).first;
    } else {
      if (itemMaster.homeName == null) {
        itemMaster.homeName = _homesNames[0];
      }
      if (_homesNames.isEmpty) {
        itemMaster.homeName = '';
        _homesNames.add(itemMaster.homeName);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Text(
                'Item\'s name: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter a name for your Item',
                    border: OutlineInputBorder()),
                controller: _nameController,
                onChanged: (name) {
                  name = _nameController.text.toString();
                  itemMaster.name = name;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Text(
                'Item\'s description: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter a description for your Item',
                    border: OutlineInputBorder()),
                controller: _descriptionController,
                onChanged: (description) {
                  description = _descriptionController.text.toString();
                  itemMaster.description = description;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Text(
                'Item\'s quantity: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: DropdownButton(
                value: itemMaster.quantity == null
                    ? itemMaster.quantity = 1
                    : itemMaster.quantity,
                items: [
                  DropdownMenuItem(
                    child: Text('1'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('2'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('3'),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text('4'),
                    value: 4,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    itemMaster.quantity = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Text(
                'Select the home for the object: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: DropdownButton<String>(
                value: itemMaster.homeName == null
                    ? _homesNames[0]
                    : itemMaster.homeName,
                items: _homesNames.map((location) {
                  return new DropdownMenuItem(
                      value: location, child: new Text(location));
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    itemMaster.homeName = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.grey,
            heroTag: "btn1",
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              if (choiceMaster) {
                _home.items.remove(itemMaster);
              }

              itemMaster.getHome(itemMaster.homeName).items.add(itemMaster);
              Navigator.pushNamed(context, 'homepage');
            },
            child: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
