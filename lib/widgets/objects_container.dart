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

  Widget appBarTitle;
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _isSearching;
  String _searchText = "";
  List searchresult = [];

  _EditObjectContainerState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    if (childs != null) {
      for (int i = 0; i < childs.length; i++) {
        _list.add(childs[i]);
      }
    } else {
      _list = []; 
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        widget.title,
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    ObjectSelections objectSelections = Provider.of<ObjectSelections>(context);

    childsParents = new Map();
    log(widget.title);
    log(widget.key.toString());
    log(widget.indexes.toString());
    
    print(searchresult.length);

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
          title: appBarTitle,
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
                    icon: icon,
                    onPressed: () {
                      setState(() {
                        if (this.icon.icon == Icons.search) {
                          this.icon = new Icon(
                            Icons.close,
                            color: Colors.white,
                          );
                          this.appBarTitle = new TextField(
                            controller: _controller,
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                            decoration: new InputDecoration(
                                prefixIcon:
                                    new Icon(Icons.search, color: Colors.white),
                                hintText: "Search...",
                                hintStyle: new TextStyle(color: Colors.white)),
                            onChanged: searchOperation,
                          );
                          _handleSearchStart();
                        } else {
                          _handleSearchEnd();
                        }
                      });
                    },
                  ),
                  IconButton(
                      icon: childs is Item ? null : Icon(Icons.sort), //TODO
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
        body: childs.length > 0 && _isSearching == false
            ? buildListObjects(objectSelections)
            : childs.length > 0 && _isSearching == true
                ? new Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Flexible(
                            child: searchresult.length != 0 ||
                                    _controller.text.isNotEmpty
                                ? new ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchresult.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String listData = searchresult[index];
                                      return new ListTile(
                                        title: new Text(listData.toString()),
                                      );
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.all(30),
                                    child: Text("No search results"),
                                  ))
                      ],
                    ),
                  )
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
