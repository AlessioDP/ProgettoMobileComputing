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
  ListedObject parent;
  Item item;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _quantityController;
  Color savedColor;
  var checkBoxValue = false;

  bool _validName = true;

  void changeColor(Color color) {
    setState(() => savedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final EditItemArguments args = ModalRoute.of(context).settings.arguments;

    parent = Data.getObjectAtIndex(args.indexParent);
    item = args.indexItem != null ? parent.getChilds()[args.indexItem] : null;
    if (_nameController == null)
      _nameController = TextEditingController(text: item?.name);
    if (_descriptionController == null)
      _descriptionController = TextEditingController(text: item?.description);
    if (_quantityController == null)
      _quantityController =
          TextEditingController(text: item?.quantity.toString());
    checkBoxValue = item.place;
    Color pickerColor = savedColor ??
        (item != null
            ? Color(int.parse(item.color, radix: 16))
            : Color(0xffffffff));

    return Scaffold(
      appBar: AppBar(
        title: Text(item != null ? 'Edit ' + item.name : 'New item'),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                'Name: ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  errorText: _validName ? null : 'You must insert a valid name',
                ),
                controller: _nameController,
                onChanged: (name) {
                  name = _nameController.text.toString();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                'Description: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder()),
                controller: _descriptionController,
                onChanged: (description) {
                  description = _descriptionController.text.toString();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: Text(
                            'Quantity:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: DropdownButton(
                            value: int.tryParse(_quantityController.text) ?? 1,
                            items: _generateQuantity(),
                            onChanged: (value) {
                              setState(() {
                                _quantityController.text = value.toString();
                              });
                            },
                          ),
                        ),
                      ]
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'Place:',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Checkbox(
                              value: checkBoxValue,
                              activeColor: Colors.blue,
                              onChanged: (bool newValue) {
                                setState(() {
                                  checkBoxValue = newValue;
                                });
                              }),
                        ),
                      ],
                    ),
                    RaisedButton(
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
                          }
                        );
                      }
                    )
                  ]
                )
              )
            )
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () async {
              if (_nameController.text.isEmpty) {
                setState(() => _validName = false);
                return;
              }

              if (item == null) {
                item = Item.empty();
                parent.getChilds().add(item);
              }
              item.name = _nameController.text.toString();
              item.description = _descriptionController.text.toString();
              item.quantity =
                  int.tryParse(_quantityController.text.toString()) ?? 1;
              item.color = pickerColor.toString().split('(0x')[1].split(')')[0];
              item.place = checkBoxValue;

              await Database.save();

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

  List _generateQuantity() {
    List<DropdownMenuItem<int>> ret = [];
    for (int i = 1; i <= 50; i++) {
      ret.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      ));
    }
    return ret;
  }
}
