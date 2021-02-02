import 'dart:developer';

import 'package:SearchIt/data/database.dart';
import 'package:SearchIt/routes.dart';
import 'package:SearchIt/widgets/objects_selections.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/widgets/side_bar.dart';
import 'package:provider/provider.dart';

class EditObjectContainer extends StatefulWidget {
  final String title;
  final ListedObject parent;
  final List<ListedObject> objects;

  final Drawer drawer;
  final FFNavigationBar bottomNavigationBar;
  final Widget floatingButton;
  final Widget body;

  EditObjectContainer({
    Key key,
    this.title, this.parent, this.objects, this.drawer, this.bottomNavigationBar, this.floatingButton, this.body
    }) : super(key: key);

  @override
  _EditObjectContainerState createState() => _EditObjectContainerState();
}

class _EditObjectContainerState extends State<EditObjectContainer> {
  @override
  Widget build(BuildContext context) {
    ObjectSelections objectSelections = Provider.of<ObjectSelections>(context);

    return Scaffold(
      drawer: widget.drawer,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingButton,
      appBar: AppBar(
        leading: objectSelections.isSelectionMode()
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  objectSelections.removeAll();
                })
            : (widget.parent != null ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }) : null),
        title: Text(widget.title),
        actions: objectSelections.isSelectionMode()
            ? <Widget>[
              // TODO - Check if count == 1
                IconButton(
                    icon: (objectSelections.count() == 1)
                        ? Icon(Icons.edit)
                        : Icon(null),
                    tooltip: 'Edit',
                    onPressed: () {
                      ListedObject lo = objectSelections.objects.first;
                      objectSelections.removeAll();

                      if (lo is Home)
                        Navigator.pushNamed(context, '/edit_home', arguments: EditHomeArguments(lo))
                        .then((value) {
                          if (value ?? false) {
                            setState(() {});
                          }
                        });
                      else if (lo is Item) {
                        Navigator.pushNamed(context, '/edit_item', arguments: EditItemArguments(widget.parent, lo))
                        .then((value) {
                          if (value ?? false) {
                            setState(() {});
                          }
                        });
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.delete_outline),
                    tooltip: 'Delete',
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Are you sure you want to delete these?'),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                                ElevatedButton(
                                    onPressed: () {
                                      if (widget.parent != null) {
                                        objectSelections.objects.forEach((element) {
                                          widget.parent.deleteChild(element);
                                        });
                                      } else {
                                        objectSelections.objects.forEach((element) {
                                          data.homes.remove(element);
                                        });
                                      }
                                      objectSelections.removeAll();
                                      Database.save();
                                      Navigator.pop(context);
                                    },
                                    child: Text('yes'))
                              ],
                            );
                          });
                    })
              ]
            : <Widget>[/*
                IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          List<String> sortListHome = [
                            'Home\'s name',
                            'Last Add'
                          ];
                          List<String> sortListItem = [
                            'Item\'s name (A-Z)',
                            'Item\'s home name (A-Z)',
                            'Last add'
                          ];
                          return AlertDialog(
                              content: Container(
                            height: 180,
                            width: 400,
                            child: ListView(
                              children: status == 0
                                  ? List.generate(sortListHome.length, (index) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            sortedHome = index;
                                            Navigator.pop(context);
                                          });
                                        },
                                        leading: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          child: Text(sortListHome[index]),
                                        ),
                                      );
                                    })
                                  : List.generate(sortListItem.length, (index) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            sortedItem = index;
                                            Navigator.pop(context);
                                          });
                                        },
                                        leading: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          child: Text(sortListItem[index]),
                                        ),
                                      );
                                    }),
                            ),
                          ));
                        },
                      );
                    }),*/
              ],
      ),
      body: buildListObjects(objectSelections)
    );
  }

  Widget buildListObjects(ObjectSelections objectSelections) {
    return ListView.separated(
      itemCount: widget.objects.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        return ListTile(
          onLongPress: () {
            objectSelections.toggle(widget.objects[index]);
          },
          onTap: () {
            setState(() {
              if (objectSelections.isSelectionMode()) {
                objectSelections.toggle(widget.objects[index]);
              } else {
                Navigator.pushNamed(
                  context,
                  '/itempage',
                  arguments: ItempageArguments(widget.objects[index])
                );
              }
            });
          },
          selected: objectSelections.contains(widget.objects[index]),
          leading: Icon(
            widget.objects[index] is Home ? Icons.home
            : ((widget.objects[index] as Item).place ? Icons.folder : Icons.article)
          
          ),
          title: Row(children: [
            Text(
              widget.objects[index].name,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
          ]),
          trailing: (objectSelections.isSelectionMode())
              ? ((objectSelections.contains(widget.objects[index]))
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank))
              : null,
        );
      });
  }
}