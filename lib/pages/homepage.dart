import 'package:SearchIt/data/objects.dart';
import 'package:SearchIt/routes.dart';
import 'package:SearchIt/widgets/objects_container.dart';
import 'package:SearchIt/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/widgets/add_floating_button.dart';
import 'package:SearchIt/data/database.dart';
import 'dart:developer';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_launcher_icons/android.dart';

//Si deve salvare lo stato alla chiusura dell'app così l'utente si ritroverà l'interfaccia con cui ha chiuso l'app
/*int status = 0;
bool choice = false;
Item itemToEdit;
Home homeToEdit;
Item itemToDisplay;
Home homeToDisplay;
int sortedItem = -1;
int sortedHome = -1;*/

class Homepage extends StatefulWidget {
  Homepage({Key key})
  : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isItemsPage = false;

  void showHomes() {
    setState(() {
      _isItemsPage = false;
    });
  }

  void showItems() {
    setState(() {
      _isItemsPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomepageArguments args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      // Args can be null if this widget is loaded directly
      _isItemsPage = args.itemsPage;
    }
    return EditObjectContainer(
      title: 'Homepage',
      objects: new List<ListedObject>.from(data.homes),
      drawer: sideBar(
        context,
        selectedButton: _isItemsPage ? SidebarButton.items : SidebarButton.homes
      ),
      bottomNavigationBar: navigationBar(),
      floatingButton: floatingButtonForHomes(context),
    );
  }

  FFNavigationBar navigationBar() {
    int _selectedIndex = this._isItemsPage ? 1 : 0;
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.blue,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black),
      selectedIndex: _selectedIndex,
      onSelectTab: (index) {
        if (index != _selectedIndex) {
          if (index == 0) {
            showHomes();
          } else if (index == 1) {
            showItems();
          }
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

  FloatingActionButton floatingButtonForHomes(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //Home home = Home.empty();
        Navigator.pushNamed(context, '/edit_home', arguments: EditHomeArguments(null))
        .then((value) => {
          if (value ?? false) {
            setState(() {})
          }
        });
      },
      tooltip: 'Add home',
      child: Icon(Icons.add)
    );
  }
}
