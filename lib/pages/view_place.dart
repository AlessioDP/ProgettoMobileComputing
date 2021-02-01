import 'package:SearchIt/data/database.dart';
import 'package:SearchIt/pages/view_home.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:flutter_tree/flutter_tree.dart';

class ViewPlace extends StatelessWidget {
  final Place place;

  ViewPlace({this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ViewPlace(place: place),
    );
  }
}

class _ViewPlace extends StatefulWidget {
  final Place place;

  _ViewPlace({this.place});

  @override
  __ViewPlaceState createState() => __ViewPlaceState(placeMaster: place);
}

class __ViewPlaceState extends State<_ViewPlace> {
  final Place placeMaster;
  __ViewPlaceState({this.placeMaster});
  final _placeNameController = TextEditingController();
  final _placeDescrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _placeNameController.text = '';
    _placeDescrController.text = '';
    /* Place place1 = new Place('test1', 'descritione1');
    place1.places.add(new Place('test2', 'descritione2'));
    place.places.add(place1);*/
    return Scaffold(
      appBar: AppBar(
        title: Text(placeMaster.name),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Place place = new Place.empty();
                return dialogAddPlace(context, place);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            itemBuilder: _buildRolesList,
            itemCount: placeMaster.places.length,
            shrinkWrap: true,
          ),
        ],
      ),
      /*Expanded(child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: ,
            itemCount: place.places[0].places.length,
          ))*/
    );
  }

  /* Widget _buildList(BuildContext context, int index) {
    return ListTile(
      title: Text(myList[index]),
    );
  }
*/
//TODO @AlessioDP ora fai quello che devi
  Widget _buildRolesList(BuildContext context, int index) {
    return ListTile(
      dense: true,
      title: ExpansionTile(
        title: Text(placeMaster.places[index].name),
        children: [
          SizedBox(
            child: ListView.builder(
              itemBuilder: _buildRolesList,
              itemCount: placeMaster.places[index].places.isEmpty
                  ? 0
                  : placeMaster.places[index].places.length,
              shrinkWrap: true,
            ),
          )
        ],
      ),
      onTap: () {},
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
                      placeMaster.places.add(place);
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
