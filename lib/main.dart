import 'package:SearchIt/pages/edit_home.dart';
import 'package:SearchIt/pages/edit_item.dart';
import 'package:SearchIt/pages/settings.dart';
import 'package:SearchIt/pages/view_home.dart';
import 'package:SearchIt/pages/view_item.dart';
import 'package:SearchIt/pages/view_place.dart';
import 'package:SearchIt/widgets/objects_selections.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/pages/homepage.dart';
import 'package:SearchIt/pages/itempage.dart';
import 'package:SearchIt/pages/login.dart';
import 'package:SearchIt/data/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Database.init();
  await Database.load();
  await Settings.init();

  runApp(ChangeNotifierProvider(
      create: (context) => ObjectSelections(), child: App()));
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SearchIt',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/homepage': (context) => Homepage(),
          '/itempage': (context) => Itempage(),
          '/login': (context) => LoginPage(),

          '/edit_home': (context) => EditHome(),
          '/edit_item': (context) => EditItem(),
          '/view_item': (context) => ViewItem(),
          //'/view_home': (context) => ViewHome(),
          //'/view_place': (context) => ViewPlace(),

          '/settings': (context) => SettingsPage(),
          //'/home': (context) => null,
          //'/home/edit': (context) => null,
          //'/item': (context) => null,
          //'/item/edit': (context) => null,
        },
        home: FutureBuilder(
            future: _firebase,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // Error on loading
                print('Error ${snapshot.error.toString()}');
                return Text('Something gone wrong!');
              } else if (snapshot.hasData) {
                // Firebase loaded
                firebaseUser = FirebaseAuth.instance.currentUser;
                if (firebaseUser != null) {
                  // Shows homepage
                  return Homepage();
                } else {
                  // Login page
                  return LoginPage();
                }
              } else {
                // Firebase loading
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
