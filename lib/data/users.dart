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
  //list of all objects

  //Empty Constructor
  Users.empty() {
    this.id = Uuid();
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
