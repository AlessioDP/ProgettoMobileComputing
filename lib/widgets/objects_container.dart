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
  //final ListedObject parent;
  final List<int> indexes;
  //final List<ListedObject> objects;

  final Drawer drawer;
  final FFNavigationBar bottomNavigationBar;
  final Widget floatingButton;
  final Widget body;

  EditObjectContainer(
      {Key key,
      this.title,
      //this.parent,
      this.indexes,
      //this.objects,
      this.drawer,
      this.bottomNavigationBar,
      this.floatingButton,
      this.body})
      : super(key: key);

  @override
  _EditObjectContainerState createState() => _EditObjectContainerState();
}

class _EditObjectContainerState extends State<EditObjectContainer> {
  ListedObject parent;
  List<ListedObject> childs;
  Map childsParents;
  var sort;

  var isItemPage = false;

  @override
  Widget build(BuildContext context) {
    ObjectSelections objectSelections = Provider.of<ObjectSelections>(context);
    childsParents = new Map();
    log(widget.title);
    log(widget.key.toString());
    log(widget.indexes.toString());
    if (widget.indexes == null) {
      isItemPage = true;
      childs = [];

      Data.getAllItems().forEach((element) {
        childs.add(element["item"]);
        childsParents[element["item"]] = element["index"];
      });
    } else if (widget.indexes.length > 0) {
      isItemPage = false;
      parent = Data.getObjectAtIndex(widget.indexes);
      childs = parent.getChilds();

      for (int c = 0; c < childs.length; c++) {
        childsParents[childs[c]] = c;
      }
    } else {
      isItemPage = false;
      childs = data.homes;
    }

    if (sort == 0) {
      childs.sort((a, b) => a.getName().compareTo(b.getName()));
    }
    if (sort == 1) {
      childs.reversed.toList();
    }

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
              : (parent != null
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                  : null),
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
                          Navigator.pushNamed(context, '/edit_home',
                                  arguments:
                                      EditHomeArguments(childs.indexOf(lo)))
                              .then((value) {
                            if (value ?? false) {
                              setState(() {});
                            }
                          });
                        else if (lo is Item) {
                          List<int> parentIndex;
                          int itemIndex;
                          if (isItemPage) {
                            parentIndex = new List.of(childsParents[lo]);
                            itemIndex = parentIndex.removeLast();
                          } else {
                            parentIndex = widget.indexes;
                            itemIndex = childsParents[lo];
                          }

                          Navigator.pushNamed(context, '/edit_item',
                                  arguments:
                                      EditItemArguments(parentIndex, itemIndex))
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
                                content: Text(
                                    'Are you sure you want to delete these?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No')),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (parent != null) {
                                          objectSelections.objects
                                              .forEach((element) {
                                            parent.getChilds().remove(element);
                                          });
                                        } else {
                                          objectSelections.objects
                                              .forEach((element) {
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
              : <Widget>[
                  IconButton(
                      icon: isItemPage ? Icon(Icons.sort) : Icon(null), //TODO
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
                              'Last add'
                            ];
                            return AlertDialog(
                                content: Container(
                              height: 120,
                              width: 400,
                              child: ListView(
                                children: childs is Home //TODO
                                    ? List.generate(sortListHome.length,
                                        (index) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              //sortedHome = index;
                                              Navigator.pop(context);
                                            });
                                          },
                                          leading: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Text(sortListHome[index]),
                                          ),
                                        );
                                      })
                                    : List.generate(sortListItem.length,
                                        (index) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              sort = index;
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
                      }),
                ],
        ),
        body: childs.length > 0
            ? buildListObjects(objectSelections)
            : Center(
                child: Text("Press the + below to add " +
                    (parent == null ? "a home" : "an item"))));
  }

  Widget buildListObjects(ObjectSelections objectSelections) {
    return ListView.separated(
        itemCount: childs.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {
              objectSelections.toggle(childs[index]);
            },
            onTap: () {
              //setState(() {
              if (objectSelections.isSelectionMode()) {
                objectSelections.toggle(childs[index]);
              } else {
                if (childs[index] is Item &&
                    !((childs[index] as Item).isPlace())) {
                  List<int> parentIndex;
                  if (isItemPage) {
                    parentIndex = new List.of(childsParents[childs[index]]);
                  } else {
                    parentIndex = widget.indexes;
                  }

                  Navigator.pushNamed(context, '/view_item',
                      arguments: ViewItemArguments(parentIndex, childs[index]));
                } else {
                  Navigator.pushNamed(context, '/itempage',
                      arguments: ItempageArguments(
                          [...(widget.indexes ?? []), index]));
                }
              }
              //});
            },
            selected: objectSelections.contains(childs[index]),
            leading: Icon(childs[index] is Home
                ? Icons.home
                : ((childs[index] as Item).isPlace()
                    ? Icons.folder
                    : Icons.article)),
            title: Row(children: [
              Text(
                childs[index].getName(),
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ]),
            subtitle: childs[index].getDescription().isNotEmpty
                ? Text(
                    childs[index].getDescription(),
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  )
                : null,
            trailing: (objectSelections.isSelectionMode())
                ? ((objectSelections.contains(childs[index]))
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank))
                : (childs[index].getColor() != null
                    ? Icon(Icons.circle,
                        color: Color(
                            int.parse(childs[index].getColor(), radix: 16)))
                    : null),
          );
        });
  }
}
