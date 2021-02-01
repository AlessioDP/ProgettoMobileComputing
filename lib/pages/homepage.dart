import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/widgets/add_floating_button.dart';
import 'package:SearchIt/data/database.dart';
import 'dart:developer';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_launcher_icons/android.dart';

//Si deve salvare lo stato alla chiusura dell'app così l'utente si ritroverà l'interfaccia con cui ha chiuso l'app
int status = 0;
bool choice = false;
Item itemToEdit;
Home homeToEdit;
Item itemToDisplay;
Home homeToDisplay;
int sortedItem = -1;
int sortedHome = -1;

/*class Homepage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return 

    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      /*
      initialRoute: '/',
      routes: {
        '/': (context) => _Homepage(title: title),
        '/login': (context) => LoginPage(),
        '/edit_item': (context) =>
            EditItem(key: key, choice: choice, item: itemToEdit),
        '/edit_home': (context) =>
            EditHome(key: key, choice: choice, home: homeToEdit),
        '/view_item': (context) => ViewItem(item: itemToDisplay),
        '/view_home': (context) => ViewHome(home: homeToDisplay),
      },*/
      //initialRoute: '', //write home route here
      //routes: //import routes from routes.dart
    );
  }
}
*/
class Homepage extends StatefulWidget {
  bool items = false;

  Homepage({bool items = false}) {
    this.items = items;
  }

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool selectingMode = false;

  getAppBar() {
    List<Item> items = Item.getAllItem(sortedItem);
    List<Home> homes = data.homes;
    return AppBar(
      leading: selectingMode
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  selectingMode = false;
                  if (status == 1) {
                    items.forEach((item) {
                      item.selected = false;
                    });
                  }
                  if (status == 0) {
                    data.homes.forEach((home) {
                      home.selected = false;
                    });
                  }
                });
              })
          : null,
      title: Text('Homepage'),
      actions: selectingMode
          ? <Widget>[
              IconButton(
                  icon: (Item.onlyOneSelected(items) || Home.onlyOneSelected())
                      ? Icon(Icons.edit)
                      : Icon(null),
                  tooltip: 'Edit',
                  onPressed: () {
                    if (status == 1) {
                      choice = true;
                      itemToEdit =
                          items.firstWhere((item) => item.selected == true);
                      selectingMode = false;
                      items.forEach((element) {
                        element.selected = false;
                      });
                      Navigator.pushNamed(context, '/edit_item');
                    }
                    if (status == 0) {
                      choice = true;
                      homeToEdit =
                          homes.firstWhere((home) => home.selected == true);
                      selectingMode = false;
                      homes.forEach((home) {
                        home.selected = false;
                      });
                      Navigator.pushNamed(context, '/edit_home');
                    }
                  }),
              IconButton(
                  icon: Icon(Icons.delete_outline),
                  tooltip: status == 0 ? 'Delete Home' : 'Delete Item',
                  onPressed: () {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: status == 0
                                ? Text(
                                    'Are you sure you want to delete those houses?')
                                : Text(
                                    'Are you sure you want to delete those items?'),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No')),
                              ElevatedButton(
                                  onPressed: () {
                                    if (status == 0) {
                                      setState(() {
                                        Home.removeAllSelectedHomes();
                                        selectingMode = false;
                                        Navigator.pop(context);
                                      });
                                    }
                                    if (status == 1) {
                                      setState(() {
                                        Item.removeAllSelectedItems();
                                        selectingMode = false;
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: Text('yes'))
                            ],
                          );
                        });
                  })
            ]
          : <Widget>[
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
                  }),
            ],
    );
  }

  Widget bodyHomepageHomes() {
    List<Home> homes = data.getHomes(sortedHome);

    return ListView(
      children: List.generate(homes.length, (index) {
        return ListTile(
          onLongPress: () {
            setState(() {
              homes[index].selected = true;
              selectingMode = true;
            });
          },
          onTap: () {
            setState(() {
              if (selectingMode) {
                homes[index].selected = !homes[index].selected;
                log(homes[index].selected.toString());
              } else {
                homeToDisplay = homes[index];
                Navigator.pushNamed(context, '/view_home');
              }
            });
          },
          selected: homes[index].selected,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Text(
                homes[index].name,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          trailing: (selectingMode)
              ? ((homes[index].selected)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank))
              : null,
        );
      }),
    );
  }

  Widget bodyHomepageItems() {
    List<Item> items =
        Item.getAllItem(sortedItem); // Wip: Collect all objects in homes
    return ListView(
      children: List.generate(items.length, (index) {
        return ListTile(
          onLongPress: () {
            setState(() {
              items[index].selected = true;
              selectingMode = true;
            });
          },
          onTap: () {
            setState(() {
              if (selectingMode) {
                items[index].selected = !items[index].selected;
                log(items[index].selected.toString());
              } else {
                itemToDisplay = items[index];
                Navigator.pushNamed(context, '/view_item');
              }
            });
          },
          selected: items[index].selected,
          title: Text(items[index].name,
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          subtitle: Text(
            '/' +
                items[index].homeName +
                (items[index].homeName.isNotEmpty
                    ? ('/' + items[index].placeName)
                    : ''),
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.right,
          ),

          /*leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Text(
                items[index].name == null ? 'error' : items[index].name,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ), */
          trailing: (selectingMode)
              ? ((items[index].selected)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank))
              : null,
        );
      }),
    );
  }

  FFNavigationBar navigationBar(int selectedIndex) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.blue,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        if (index == 0 && index != selectedIndex) {
          setState(() {
            status = 0;
          });
        }
        if (index == 1 && index != selectedIndex) {
          setState(() {
            status = 1;
          });
        }
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.home,
          label: 'Homes',
        ),
        FFNavigationBarItem(
          iconData: Icons.article,
          label: 'Items',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideBar(context),
      appBar: getAppBar(),
      bottomNavigationBar: navigationBar(status),
      body: status == 0
          ? bodyHomepageHomes()
          : status == 1
              ? bodyHomepageItems()
              : null,
      floatingActionButton: floatingButton(context),
    );
  }
}
