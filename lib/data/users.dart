import 'package:SearchIt/data/homes.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:uuid/uuid.dart';

class Users {
  Uuid id;
  String name;
  String lastName;
  String email;
  String bornDate;
  String userName;
  String password;
  //list of home
  List<Homes> homes; //One to many
  List<Objects> objects;
  //list of all objects or map with key 'home'. idk

  //Empty Constructor
  Users.empty() {
    this.id = Uuid();
    this.homes = new List();
    this.objects = new List();
  }

  //Basic Constructor
  Users(String name, String lastName, String email, String bornDate,
      String userName, String password) {
    this.id = Uuid();
    this.name = name;
    this.lastName = lastName;
    this.email = email;
    this.bornDate = bornDate;
    this.userName = userName;
    this.password = password;
  }
}
