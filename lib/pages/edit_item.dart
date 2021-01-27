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
    itemMaster = item;
    String title;

    if (choice) {
      title = editTitle;
    } else {
      title = newTitle;
    }

    return MaterialApp(
        title: choice ? editTitle : newTitle,
        theme: theme(),
        home: _EditItem(
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

  @override
  Widget build(BuildContext context) {
    var _quantity;

    String newName;
    String newDescription;

    List<Home> _homes = data.homes;
    String _homeName;
    Home _home;

    if (choiceMaster) {
      _homeName = itemMaster.homeName;
      _quantity = itemMaster.quantity;
      _home = _homes.where((element) => element.name == _homeName).first;
    } else {
      _homeName = '';
      _quantity = 1;
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
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter a name for your Item',
                    border: OutlineInputBorder()),
                initialValue: choiceMaster ? itemMaster.name : '',
                validator: (itemName) {
                  if (itemName.isEmpty) {
                    return 'Enter the name of the item';
                  } else {
                    newName = itemName;
                    return null;
                  }
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
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter a description for your Item',
                    border: OutlineInputBorder()),
                initialValue: choiceMaster ? itemMaster.description : '',
                validator: (itemDescription) {
                  if (itemDescription.isEmpty) {
                    return 'Enter the description of the item';
                  } else {
                    newDescription = itemDescription;
                    return null;
                  }
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
                value: _quantity,
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
                    _quantity = value;
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
                value: _homeName,
                onChanged: (String newValue) {
                  setState(() {
                    _homeName = newValue;
                  });
                },
                items: _homes.map((Home map) {
                  return new DropdownMenuItem<String>(
                      value: map.name, child: new Text(map.name));
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              itemMaster.name = newName;
              itemMaster.description = newDescription;
              itemMaster.quantity = _quantity;
              itemMaster.homeName = _homeName;

              if (choiceMaster) {
                _home.items.remove(itemMaster);
              }

              itemMaster.getHome(_homeName).items.add(itemMaster);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage(
                            title: 'Homepage',
                          )));
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
