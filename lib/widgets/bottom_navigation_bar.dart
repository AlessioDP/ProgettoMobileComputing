import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

FFNavigationBar navigationBar(int selectedIndex) {
  return FFNavigationBar(
    theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBackgroundColor: Colors.green,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black),
    selectedIndex: selectedIndex,
    onSelectTab: (index) {
      if (index == 0 && index != selectedIndex) {
        //list of home
      }
      if (index == 1 && index != selectedIndex) {
        //list of objects
      }
    },
    items: [
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'Homes',
      ),
      FFNavigationBarItem(
        iconData: Icons.article,
        label: 'Objects',
      )
    ],
  );
}
