import 'package:SearchIt/routes.dart';
import 'package:SearchIt/widgets/objects_container.dart';
import 'package:SearchIt/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';


class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _userChoise = false;
  bool _isItemsPage = false;

  void showHomes() {
    setState(() {
      _userChoise = true;
      _isItemsPage = false;
    });
  }

  void showItems() {
    setState(() {
      _userChoise = true;
      _isItemsPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomepageArguments args = ModalRoute.of(context).settings.arguments;
    if (!_userChoise && args != null) {
      // Args can be null if this widget is loaded directly
      _isItemsPage = args.itemsPage;
    }
    return EditObjectContainer(
      title: _isItemsPage ? 'ItemPage' : 'Homepage',
      indexes: _isItemsPage ? null : [],
      //  objects: _isItemsPage ? getAllItems() : data.homes,
      drawer: sideBar(context,
          selectedButton:
              _isItemsPage ? SidebarButton.items : SidebarButton.homes),
      bottomNavigationBar: navigationBar(),
      floatingButton: _isItemsPage ? null : floatingButtonForHomes(context),
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
          Navigator.pushNamed(context, '/edit_home',
                  arguments: EditHomeArguments(null))
              .then((value) {
            if (value ?? false) {
              setState(() {});
            }
          });
        },
        tooltip: 'Add home',
        child: Icon(Icons.add));
  }
}
