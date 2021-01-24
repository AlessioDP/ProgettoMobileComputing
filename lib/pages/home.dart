import 'package:flutter/material.dart';
import 'package:SearchIt/widgets/bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      //initialRoute: '', //write home route here
      //routes: //import routes from routes.dart
      home: _Home(key: key, title: title),
    );
  }
}

class _Home extends StatefulWidget {
  _Home({Key key, this.title}) : super(key: key);

  final title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  getAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: navigationBar(0),
    );
  }
}
