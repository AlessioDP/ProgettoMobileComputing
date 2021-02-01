import 'package:SearchIt/pages/edit_home.dart';
import 'package:SearchIt/pages/edit_item.dart';
import 'package:SearchIt/pages/view_home.dart';
import 'package:SearchIt/pages/view_item.dart';
import 'package:SearchIt/pages/view_place.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/users.dart';
import 'package:SearchIt/pages/homepage.dart';
import 'package:SearchIt/pages/login.dart';
import 'package:SearchIt/data/database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:SearchIt/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  //Database().read();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
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
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('it', 'IT'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        /*
        initialRoute: '/',
        routes: {
          '/': (context) => Login(title: title),
        }*/

        routes: {
          '/homepage': (context) => Homepage(),
          '/login': (context) => LoginPage(),
          '/edit_item': (context) =>
              EditItem(key: key, choice: choice, item: itemToEdit),
          '/edit_home': (context) =>
              EditHome(key: key, choice: choice, home: homeToEdit),
          '/view_item': (context) => ViewItem(item: itemToDisplay),
          '/view_home': (context) => ViewHome(home: homeToDisplay),
          '/view_place': (context) => ViewPlace(place: placeToView),
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
