import 'package:SearchIt/data/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SearchIt/main.dart';
import 'package:uuid/uuid.dart';

Users loggedUser = Users.empty();

class Database {
  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final user = loggedUser;
    prefs.setString('name', user.name);
    prefs.setString('lastName', user.lastName);
    prefs.setString('email', user.email);
    prefs.setString('bornDate', user.bornDate);
    prefs.setString('userName', user.userName);
    prefs.setString('password', user.password);
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final user = Users.empty();
    user.name = prefs.getString('name') ?? "";
    user.lastName = prefs.getString('lastName') ?? "";
    user.email = prefs.getString('email') ?? "";
    user.bornDate = prefs.getString('bornDate') ?? "";
    user.userName = prefs.getString("userName") ?? "";
    user.userName = prefs.getString('password') ?? "";
  }
}
