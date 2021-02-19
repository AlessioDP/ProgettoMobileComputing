import 'dart:developer';

import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/routes.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/constants.dart';
import 'package:SearchIt/data/database.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'homepage.dart';

class EditHome extends StatefulWidget {
  EditHome({Key key}) : super(key: key);

  @override
  _EditHomeState createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  Home home;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  Color savedColor;

  bool _validName = true;

  void changeColor(Color color) {
    setState(() => savedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final EditHomeArguments args = ModalRoute.of(context).settings.arguments;

    home = args.indexHome != null ? data.homes[args.indexHome] : null;
    if (_nameController == null)
      _nameController = TextEditingController(text: home?.name);
    if (_descriptionController == null)
      _descriptionController = TextEditingController(text: home?.description);
    Color pickerColor = savedColor ??
        (home != null
            ? Color(int.parse(home.color, radix: 16))
            : Color(0xffffffff));

    return Scaffold(
      appBar: AppBar(
        title: Text(home != null ? 'Edit ' + home.name : 'New home'),
      ),
      body: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Text(
              'Name:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                errorText: _validName ? null : 'You must insert a valid name',
              ),
              controller: _nameController,
              onChanged: (name) {
                name = _nameController.text.toString();
              },

              
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Text(
              'Description:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder()
              ),
              controller: _descriptionController,
              onChanged: (name) {
                name = _descriptionController.text.toString();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Center(
              child: RaisedButton(
              elevation: 2.0,
              child: Text('Set a color'),
              color: pickerColor,
              textColor: useWhiteForeground(pickerColor)
                  ? const Color(0xffffffff)
                  : const Color(0xff000000),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                    );
                  }
                );
              }
            )
          )
        )
      ])),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              if (_nameController.text.isEmpty) {
                setState(() => _validName = false);
                return;
              }

              if (home == null) {
                home = Home.empty();
                data.homes.add(home);
              }
              home.name = _nameController.text.toString();
              home.description = _descriptionController.text.toString();
              home.color = pickerColor.toString().split('(0x')[1].split(')')[0];

              Database.save();
              Navigator.pop(context, true);
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
