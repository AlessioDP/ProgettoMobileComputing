import 'package:SearchIt/data/database.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/auth.dart';
import 'package:SearchIt/routes.dart';

Drawer sideBar(BuildContext context, {SidebarButton selectedButton}) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: firebaseUser.isAnonymous
            ? Text("Guest")
            : Text(firebaseUser.displayName),
        accountEmail:
            firebaseUser.isAnonymous ? null : Text(firebaseUser.email),
        currentAccountPicture: firebaseUser.isAnonymous
            ? CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person, size: 60),
              )
            : Image.network(firebaseUser.photoURL),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Homes',
            style: TextStyle(
                color: selectedButton == SidebarButton.homes
                    ? Colors.blue
                    : Colors.black)),
        onTap: () => _actionHomes(context),
      ),
      ListTile(
        leading: Icon(Icons.article),
        title: Text('Items',
            style: TextStyle(
                color: selectedButton == SidebarButton.items
                    ? Colors.blue
                    : Colors.black)),
        onTap: () => _actionItems(context),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings',
            style: TextStyle(
                color: selectedButton == SidebarButton.settings
                    ? Colors.blue
                    : Colors.black)),
        onTap: () => _actionSettings(context),
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text('About us'),
        onTap: () {
          showAboutDialog(
            context: context,
            applicationIcon: Image(image: AssetImage('assets/icons/icon.png',), height: 110,),
            applicationName: 'About us!',
            applicationVersion: 'version 0.0.1',
            applicationLegalese: 'Developed by Renzo, Alessio & Daniele',
            children: <Widget> [
              Container(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Text("This app was developed by Renzo, Alessio & Daniele for MC's exam"),
              )
            ]
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Sign out', style: TextStyle(color: Colors.black)),
        onTap: () => _actionSignOut(context),
      )
    ]),
  );
}

void _actionHomes(BuildContext context) {
  print("Home?");
  Navigator.pushReplacementNamed(context, '/homepage',
      arguments: HomepageArguments(false));
}

void _actionItems(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/homepage',
      arguments: HomepageArguments(true));
}

void _actionSettings(BuildContext context) {
  // TODO - Implement settings page
}

void _actionSignOut(BuildContext context) {
  print("Signed out?");
  authSignOut();
  Navigator.pushReplacementNamed(context, '/login');
}

enum SidebarButton { homes, items, settings }
