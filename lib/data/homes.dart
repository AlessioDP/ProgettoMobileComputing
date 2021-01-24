import 'package:SearchIt/data/users.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Homes {
  Uuid id;
  String name;
  bool selected = false;

  Users user; //Many to One
  //List of objects(probably get the objects from user (?))

  Homes.empty() {
    this.id = Uuid();
  }
  Homes.withoutUser(String name) {
    Homes.empty();
    this.name = name;
  }
}
