import 'package:SearchIt/data/users.dart';
import 'package:SearchIt/data/objects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

User firebaseUser;
LoggedUser loggedUser = LoggedUser.empty();
Data data = Data();

class Database {
  static SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future save() async {
    await _preferences.setString("data", dataToJson(data));
    await _preferences.setString("loggedUser", jsonEncode(loggedUser));

    load();
    print("Saved data:");
    print(data.homes[0].childs);
  }

  static Future load() async {
    if (_preferences.getString("data") != null)
      data = dataFromJson(_preferences.getString("data"));
    if (_preferences.getString("loggedUser") != null)
      loggedUser =
          LoggedUser.fromJson(jsonDecode(_preferences.getString("loggedUser")));
  }

  static Data dataFromJson(String json) {
    return Data.fromJson(jsonDecode(json));
  }

  static String dataToJson(Data data) {
    return jsonEncode(data);
  }

  static Data dataFromJson(String json) {
    return Data.fromJson(jsonDecode(json));
  }

  static String dataToJson(Data data) {
    return jsonEncode(data);
  }
}
