//this class will manage the view of item with all routes
import 'package:SearchIt/data/objects.dart';
import 'package:flutter/material.dart';

Home homeMaster;

class ViewHome extends StatelessWidget {
  ViewHome({this.home});

  final Home home;

  @override
  Widget build(BuildContext context) {
    homeMaster = home;

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
                        children: [
                          Icon(
                            Icons.arrow_right,
                            size: 40,
                          ),
                          Text(
                            ' ' + homeMaster.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text('Places: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 20)),
                          (Text(
                              home.places.isNotEmpty
                                  ? (home.places[0].name)
                                  : 'No such Places here!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100, fontSize: 20))),
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
}

/*
class _ViewHome extends StatefulWidget {
  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<_ViewHome> {

  @override
  Widget build(BuildContext context) {
}
*/
