//this class will manage the view of item with all routes
import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/routes.dart';
import 'package:flutter/material.dart';

class ViewItem extends StatelessWidget {
  ListedObject parent;

  ViewItem();

  @override
  Widget build(BuildContext context) {
    final ViewItemArguments args = ModalRoute.of(context).settings.arguments;

    parent = Data.getObjectAtIndex(args.indexParent);

    return Scaffold(
      appBar: AppBar(
          title: Text(args.item.name),
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
                            ' ' + args.item.name,
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
                          Text('Description: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20)),
                          Text(args.item.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.w100, fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text('Location: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20)),
                          Text(parent.getName(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w100, fontSize: 20)),
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

/*class _ViewItem extends StatefulWidget {
  @override
  _ViewItemState createState() => _ViewItemState();
}

class _ViewItemState extends State<_ViewItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                          ' ' + args.item.name,
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
                        Text('Description: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20)),
                        Text(itemMaster.description,
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text('Location: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20)),
                        Text(itemMaster.homeName,
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
*/
