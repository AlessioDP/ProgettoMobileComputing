import 'package:flutter/material.dart';
import 'package:SearchIt/auth.dart';
import 'package:SearchIt/routes.dart';

Drawer sideBar(BuildContext context, {SidebarButton selectedButton}) {
  return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('SearchIt',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24))),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'Homes',
            style: TextStyle(color: selectedButton == SidebarButton.homes ? Colors.blue : Colors.black)
          ),
          onTap: () => _actionHomes,
        ),
        ListTile(
          leading: Icon(Icons.article),
          title: Text(
            'Items',
            style: TextStyle(color: selectedButton == SidebarButton.items ? Colors.blue : Colors.black)
          ),
          onTap: () => _actionItems,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Settings',
            style: TextStyle(color: selectedButton == SidebarButton.settings ? Colors.blue : Colors.black)
          ),
          onTap: () => _actionSettings,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'Sign out',
            style: TextStyle(color: Colors.black)
          ),
          onTap: () => _actionSignOut,
        )
      ]
    ),
  );
}

void _actionHomes(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/homepage', arguments: HomepageArguments(false));
}

void _actionItems(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/homepage', arguments: HomepageArguments(true));
}

void _actionSettings(BuildContext context) {
  // TODO - Implement settings page
}

void _actionSignOut(BuildContext context) {
  authSignOut();
  Navigator.pushReplacementNamed(context, '/login');
}

enum SidebarButton {
  homes, items, settings
}
