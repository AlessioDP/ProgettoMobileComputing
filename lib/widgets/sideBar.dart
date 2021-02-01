import 'package:SearchIt/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/app_localizations.dart';
import 'package:SearchIt/auth.dart';

Drawer sideBar(BuildContext context) {
  return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
    DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text(AppLocalizations.of(context).translate('app_name'),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24))),
    ListTile(
      leading: Icon(Icons.home),
      title: Text(AppLocalizations.of(context).translate('homes')),
      onTap: () => _actionHomes,
    ),
    ListTile(
      leading: Icon(Icons.article),
      title: Text(AppLocalizations.of(context).translate('items')),
      onTap: () => _actionItems,
    ),
    Divider(),
    ListTile(
      leading: Icon(Icons.settings),
      title: Text(AppLocalizations.of(context).translate('settings')),
      onTap: () => _actionSettings,
    ),
    ListTile(
      leading: Icon(Icons.logout),
      title: Text(AppLocalizations.of(context).translate('sign_out')),
      onTap: () => _actionSignOut,
    )
  ]));
}

void _actionHomes(BuildContext context) {
  /*TODO @AlessioDP to make this works you need to try to use a setState function, make sure to use it in
  **stateful widget or it won't be able to work. Use status variable to switch between Homes and Items
  */
  status = 0;
  Navigator.pushReplacementNamed(context, '/homepage');
}

void _actionItems(BuildContext context) {
  status = 1;
  Navigator.pushReplacementNamed(context, '/homepage');
}

void _actionSettings(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/homes');
  // TODO
}

void _actionSignOut(BuildContext context) {
  authSignOut();
  Navigator.pushReplacementNamed(context, '/login');
}
