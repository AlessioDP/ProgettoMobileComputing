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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                          Text('Places: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 25, fontStyle: FontStyle.italic)),
                          Container (
                            height: 350,
                            padding: EdgeInsets.all(0),
                              child: home.places.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                        color: Colors.blue[300],
                                        width: 5,
                                      )),
                                      child: Stack(children: [
                                         Expanded(
                                           child: ListView.builder(
                                               itemCount: homeMaster.places.length,
                                               shrinkWrap: true,
                                                itemBuilder: (context, index) => ListTile(
                                                title: homeMaster.places.isEmpty
                                                ? Text('default')
                                                : Row(
                                                children: [
                                                 Icon(
                                                   Icons.arrow_right,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    '' + (homeMaster.places[index].name),
                                                    style: TextStyle(
                                                   fontWeight: FontWeight.normal, fontSize: 20),
                                                  ),
                                                ],
                                                ),
                                                ),
                                           ))
                                        ]),
                            )
                                  : Container (
                                    width: 400,
                                    height: 100,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                        color: Colors.red,
                                        width: 5,
                                      )),
                                    child: Text('No places here!'),
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
