import 'package:SearchIt/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Drawer sideBar() {
  return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
    DrawerHeader(child: Text('Example')),
    ListTile(
        title: Text('Logout'),
        onTap: () {
          // TODO
          FirebaseAuth.instance.signOut();
          // TODO back to login page
          runApp(LoginPage());
        })
  ])
      //TODO

      );
}
