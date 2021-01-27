import 'package:SearchIt/data/objects.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/constants.dart';
import 'package:SearchIt/data/database.dart';

import 'homepage.dart';

bool choiceMaster;
Home homeMaster;

class EditHome extends StatelessWidget {
  //true => edit
  //false => new
  final bool choice;
  final Home home;

  final String editTitle = 'Edit home';
  final String newTitle = 'Create new home';

  EditHome({Key key, this.choice, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    choiceMaster = choice;

    if (choiceMaster) {
      homeMaster = home;
    } else {
      homeMaster = Home.empty();
    }

    String title;
    if (choice) {
      title = editTitle;
    } else {
      title = newTitle;
    }
    return MaterialApp(
      title: title,
      theme: theme(),
      home: _EditHome(
        title: title,
      ),
    );
  }
}

class _EditHome extends StatefulWidget {
  String title;
  _EditHome({this.title});
  @override
  _EditHomeState createState() => _EditHomeState(title: title);
}

class _EditHomeState extends State<_EditHome> {
  String title;
  _EditHomeState({this.title});

  String newName;
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              'Home\'s name: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter a name for your Home',
                  border: OutlineInputBorder()),
              controller: _nameController,
              onChanged: (name) {
                name = _nameController.text.toString();
                homeMaster.name = name;
              },
            ),
          ),
        ],
      )),
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
              if (!choiceMaster) {
                data.homes.add(homeMaster);
              }
              Database.save();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage(
                            title: 'HomePage',
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
