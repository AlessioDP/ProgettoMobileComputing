import 'dart:io';

import 'package:SearchIt/data/database.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SettingsScreen(
        title: "Settings",
        children: [
          SettingsGroup(
            title: 'Data Settings',
            children: <Widget>[
              SimpleSettingsTile(
                title: "Import data",
                subtitle: "Import the data directly from a file",
                onTap: () => _actionImport(),
              ),
              SimpleSettingsTile(
                title: "Export data",
                subtitle: "Export the data to file",
                onTap: () => _actionExport(),
              )
            ],
          )
        ]
      )
    );
  }

  void _actionImport() async {
    FilePickerCross myFile = await FilePickerCross.importFromStorage(
      type: FileTypeCross.custom,
      fileExtension: 'json'
    );

    String jsonData = await new File(myFile.path).readAsString();
    data = Database.dataFromJson(jsonData);

    Fluttertoast.showToast(msg: "Data imported successfully");
  }

  void _actionExport() async {
    if (await Permission.storage.request().isGranted) {
      final directory = await ExtStorage.getExternalStorageDirectory();
      final file = File('$directory/searchit.json');

      // Write the file.
      file.writeAsString(Database.dataToJson(data));

      Fluttertoast.showToast(msg: "Data exported successfully");
    }
  }
}