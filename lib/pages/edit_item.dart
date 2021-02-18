import 'package:SearchIt/pages/homepage.dart';
import 'package:SearchIt/routes.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/constants.dart';
import 'package:SearchIt/data/database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditItem extends StatefulWidget {
  EditItem({Key key}) : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _quantityController;
  Color savedColor;
  var checkBoxValue = false;

  void changeColor(Color color) {
    setState(() => savedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final EditItemArguments args = ModalRoute.of(context).settings.arguments;

    if (_nameController == null)
      _nameController = TextEditingController(text: args.item?.name);
    if (_descriptionController == null)
      _descriptionController =
          TextEditingController(text: args.item?.description);
    Color pickerColor = savedColor ??
        (args.item != null
            ? Color(int.parse(args.item.color, radix: 16))
            : Color(0xffffffff));
    if (_quantityController == null)
      _quantityController =
          TextEditingController(text: args.item?.quantity.toString());

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
                    border: OutlineInputBorder()),
                controller: _descriptionController,
                onChanged: (description) {
                  description = _descriptionController.text.toString();
                },
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                      child: Text(
                        'Item\'s quantity: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: DropdownButton(
                        value: int.tryParse(_quantityController.text) ?? 1,
                        items: [
                          DropdownMenuItem(
                            child: Text('1'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('2'),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text('3'),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text('4'),
                            value: 4,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _quantityController.text = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Is a place: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Checkbox(
                        value: checkBoxValue,
                        activeColor: Colors.green,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Text(
                'Pick a color: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: RaisedButton(
                    elevation: 2.0,
                    child: Text('Color'),
                    color: pickerColor,
                    textColor: useWhiteForeground(pickerColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                            );
                          });
                    }))
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
                args.parent.getChilds().add(item);
              }
              item.name = _nameController.text.toString();
              item.description = _descriptionController.text.toString();
              item.quantity =
                  int.tryParse(_quantityController.text.toString()) ?? 1;
              item.color = pickerColor.toString().split('(0x')[1].split(')')[0];
              item.place = checkBoxValue;

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
