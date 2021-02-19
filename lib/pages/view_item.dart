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
                      padding: EdgeInsets.only(top: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' ' + args.item.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Text(
                              args.item.description,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w400,
                                fontSize: 20
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Text('Location:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20))
                                  
                    ),
                    Flexible(
                        child: Text(
                          _generateLocationName(parent, args.indexParent),
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 20)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Text('Quantity:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20))
                                  
                    ),
                    Container(
                      child: Text(args.item.quantity.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w100, fontSize: 20))
                                  
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

  String _generateLocationName(ListedObject parent, List<int> indexParent) {
    String ret = parent.getName();
    List<int> newIndex = [...indexParent];

    while(newIndex.length > 1) {
      ListedObject biggerParent = Data.getParentOfIndex(newIndex);
      if (biggerParent != null) {
        ret = biggerParent.getName() + " > " + ret;
      }
      newIndex.removeLast();
    }
    return ret;
  }
}
