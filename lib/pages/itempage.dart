import 'package:SearchIt/data/database.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/widgets/objects_container.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/routes.dart';
import 'package:SearchIt/widgets/side_bar.dart';

class Itempage extends StatefulWidget {
  Itempage({Key key}) : super(key: key);

  @override
  _ItempageState createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  ListedObject parent;

  @override
  Widget build(BuildContext context) {
    final ItempageArguments args = ModalRoute.of(context).settings.arguments;
    parent = Data.getObjectAtIndex(args.indexParent);

    return EditObjectContainer(
      title: parent.getName(),
      indexes: args.indexParent,
      //parent: data.homes[0],
      //objects: data.homes[0].childs,
      drawer: sideBar(context),
      floatingButton: floatingButtonForItems(context, args),
    );
  }

  FloatingActionButton floatingButtonForItems(
      BuildContext context, ItempageArguments args) {
    return FloatingActionButton(
        onPressed: () {
          //Home home = Home.empty();
          Navigator.pushNamed(context, '/edit_item',
                  arguments: EditItemArguments(args.indexParent, null))
              .then((value) => {
                    if (value ?? false) {setState(() {})}
                  });
        },
        tooltip: 'Add item',
        child: Icon(Icons.add));
  }
}
