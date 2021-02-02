import 'package:SearchIt/pages/homepage.dart';
import 'package:SearchIt/routes.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/constants.dart';
import 'package:SearchIt/data/database.dart';
import 'package:flutter/services.dart';

class EditItem extends StatefulWidget {

  EditItem({Key key})
  : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  @override
  Widget build(BuildContext context) {
    final EditItemArguments args = ModalRoute.of(context).settings.arguments;

    final _nameController = TextEditingController(text: args.item?.name);
    final _descriptionController = TextEditingController(text: args.item?.description);
    final _quantityController = TextEditingController(text: args.item?.quantity.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(args.item != null ? 'Edit ' + args.item.name : 'New item'),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                'Item\'s name: ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter a name for your Item',
                    border: OutlineInputBorder()),
                controller: _nameController,
                onChanged: (name) {
                  name = _nameController.text.toString();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                'Item\'s description: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a description for your Item',
                  border: OutlineInputBorder()
                ),
                controller: _descriptionController,
                onChanged: (description) {
                  description = _descriptionController.text.toString();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Text(
                'Item\'s quantity: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a quantity for your Item',
                  border: OutlineInputBorder(),
                ),
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                onChanged: (quantity) {
                  quantity = _quantityController.text.toString();
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Item item = args.item;
              if (item == null) {
                item = Item.empty();
                args.parent.childs.add(item);
              }
              item.name = _nameController.text.toString();
              item.description = _descriptionController.text.toString();
              item.quantity = int.tryParse(_quantityController.text.toString())?? 1;
              item.place = true; // TODO - Add form
              
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