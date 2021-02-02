import 'dart:collection';

import 'package:SearchIt/data/objects.dart';
import 'package:flutter/cupertino.dart';

class ObjectSelections extends ChangeNotifier {
  final List<ListedObject> _objects = [];

  UnmodifiableListView<ListedObject> get objects => UnmodifiableListView(_objects);

  bool isSelectionMode() {
    return _objects.length > 0;
  }

  int count() {
    return _objects.length;
  }

  bool contains(ListedObject object) {
    return _objects.contains(object);
  }

  void toggle(ListedObject object) {
    if (contains(object))
      add(object);
    else
      remove(object);
  }

  void add(ListedObject object) {
    _objects.add(object);
    notifyListeners();
  }

  void remove(ListedObject object) {
    _objects.remove(object);
    notifyListeners();
  }

  void removeAll() {
    _objects.clear();
    notifyListeners();
  }
}