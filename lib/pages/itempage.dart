import 'package:SearchIt/widgets/objects_container.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/routes.dart';
import 'package:SearchIt/widgets/side_bar.dart';

class Itempage extends StatefulWidget {
  Itempage({Key key})
  : super(key: key);

  @override
  _ItempageState createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  @override
  Widget build(BuildContext context) {
    final ItempageArguments args = ModalRoute.of(context).settings.arguments;

    return EditObjectContainer(
      title: args.parent.name,
      parent: args.parent,
      objects: args.parent.childs,
      drawer: sideBar(context)
    );
  }
}
