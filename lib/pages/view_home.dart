//this class will manage the view of item with all routes
import 'package:SearchIt/data/objects.dart';
import 'package:flutter/material.dart';

Home homeMaster;
Place placeToView;

class ViewHome extends StatelessWidget {
  ViewHome({this.home});

  final Home home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ViewHome(
        home: home,
      ),
    );
  }
}

class _ViewHome extends StatefulWidget {
  final Home home;
  _ViewHome({this.home});
  @override
  _ViewHomeState createState() => _ViewHomeState(home: home);
}

class _ViewHomeState extends State<_ViewHome> {
  final Home home;
  _ViewHomeState({this.home});

  final _placeNameController = TextEditingController();
  final _placeDescrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    homeMaster = home;
    _placeNameController.text = '';
    _placeDescrController.text = '';

    return Scaffold(
      appBar: AppBar(
          title: Text(home.name),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            size: 40,
                          ),
                          Flexible(
                              child: new Container(
                            child: Text(
                              ' ' + homeMaster.name + ' ',
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40),
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Home\'s places: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ActionChip(
                                  label: Text('+'),
                                  onPressed: () {
                                    Place place = new Place.empty();
                                    return dialogAddPlace(context, place);
                                  }),
                            ],
                          ),
                          Container(
                            width: 1000, //max width
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: Colors.blue[300],
                                  width: 5,
                                )),
                            height: 350,
                            child: home.places.isNotEmpty
                                ? Column(children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemCount: homeMaster.places.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => ListTile(
                                        onTap: () {
                                          placeToView =
                                              homeMaster.places[index];
                                          Navigator.pushNamed(
                                              context, '/view_place');
                                        },
                                        title: homeMaster.places.isEmpty
                                            ? Text('default')
                                            : Row(
                                                children: [
                                                  Icon(
                                                    Icons.arrow_right,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    '' +
                                                        (homeMaster
                                                            .places[index]
                                                            .name),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ))
                                  ])
                                : Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'No places here!',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
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
