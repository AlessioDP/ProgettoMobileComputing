import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/pages/home.dart';

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
        status = 0;
      }
      if (index == 1 && index != selectedIndex) {
        status = 1;
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
