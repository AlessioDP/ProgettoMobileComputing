import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/routes.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/constants.dart';
import 'package:SearchIt/data/database.dart';

import 'homepage.dart';

bool choiceMaster;
Home homeMaster;

class EditHome extends StatefulWidget {

  EditHome({Key key})
  : super(key: key);

  @override
  _EditHomeState createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  @override
  Widget build(BuildContext context) {
    final EditHomeArguments args = ModalRoute.of(context).settings.arguments;

    final _nameController = TextEditingController(text: args.home?.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(args.home != null ? 'Edit ' + args.home.name : 'New home'),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                'Home\'s name: ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter a name for your Home',
                    border: OutlineInputBorder()),
                controller: _nameController,
                onChanged: (name) {
                  name = _nameController.text.toString();
                },
              ),
            ),
          ],
        )
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Home home = args.home;
              if (home == null) {
                home = Home.empty();
                data.homes.add(home);
              }
              home.name = _nameController.text.toString();
              
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












  //true => edit
  //false => new
  //final bool choice;
  //final Home home;
/*
  final String editTitle = 'Edit home';
  final String newTitle = 'Create new home';

  EditHome({Key key}) : super(key: key);

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
    return Scaffold(
      body: _EditHome(
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

  final _placeNameController = TextEditingController();
  final _placeDescrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (choiceMaster) {
      _nameController.text = homeMaster.name;
    }
    _placeNameController.text = '';
    _placeDescrController.text = '';

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
          /*
          Container(
              padding: EdgeInsets.fromLTRB(10, 1, 10, 0),
              child: Row(
                children: [
                  Text(
                    'Home\'s places ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ActionChip(
                      label: Text('+'),
                      onPressed: () {
                        Place place = new Place.empty();
                        return dialogAddPlace(context, place);
                      }),
                ],
              )),
          Container(
            height: 220,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.blue[300],
                  width: 5,
                )),
            child: Column(children: [
              Expanded(
                  child: ListView.builder(
                itemCount: homeMaster.places.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  title: homeMaster.places.isEmpty
                      ? Text('default')
                      : Container(
                          child: Row(children: [
                          Icon(Icons.arrow_right),
                          Text(homeMaster.places[index].name),
                        ])),
                ),
              ))
            ]),
          ),*/
        ],
      )),
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
          /*
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              if (!choiceMaster) {
                data.homes.add(homeMaster);
              } else {
                data.homes
                    .firstWhere((home) => home == homeMaster)
                    .items
                    .forEach((item) {
                  item.homeName = homeMaster.name;
                });
              }
              Database.save();
              Navigator.pushReplacementNamed(context, '/homepage');
            },
            child: Icon(
              Icons.check,
            ),
          ),*/
        ],
      ),
    );
  }

  Future dialogAddPlace(BuildContext context, Place place) {
    return showDialog(
        //TODO mettere verifica campo vuoto
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 180,
              width: 400,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Create a place',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Place\'s name',
                          border: OutlineInputBorder()),
                      controller: _placeNameController,
                      onChanged: (name) {
                        name = _placeNameController.text.toString();
                        place.name = name;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Place\'s description',
                          border: OutlineInputBorder()),
                      controller: _placeDescrController,
                      onChanged: (descr) {
                        descr = _placeDescrController.text.toString();
                        place.description = descr;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _placeNameController.text = '';
                    _placeDescrController.text = '';
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      homeMaster.places.add(place);
                      _placeNameController.text = '';
                      _placeDescrController.text = '';
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Save')),
            ],
          );
        });
  }
}
*/
}