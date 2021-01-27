import 'package:SearchIt/data/users.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

LoggedUser loggedUser = LoggedUser.empty();
Data data = Data();

class Database {
  static save() async {
    var _prefs = await SharedPreferences.getInstance();

    _prefs.setString("loggedUser", jsonEncode(loggedUser));
    _prefs.setString("data", jsonEncode(data));
  }

  read() async {
    var _prefs = await SharedPreferences.getInstance();

    loggedUser =
        LoggedUser.fromJson(jsonDecode(_prefs.getString("loggedUser")));
    data = Data.fromJson(jsonDecode(_prefs.getString("data")));
  }
}
