import 'package:SearchIt/data/objects.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/widgets/add_floating_button.dart';
import 'package:SearchIt/data/database.dart';
import 'dart:developer';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

//Si deve salvare lo stato alla chiusura dell'app così l'utente si ritroverà l'interfaccia con cui ha chiuso l'app
int status = 0;

class Homepage extends StatelessWidget {
  Homepage({Key key, this.title}) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      //initialRoute: '', //write home route here
      //routes: //import routes from routes.dart
      home: _Homepage(key: key, title: title),
    );
  }
}

class _Homepage extends StatefulWidget {
  _Homepage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<_Homepage> {
  bool selectingMode = false;

  getAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget bodyHomepageHomes() {
    List<Home> homes = data.homes;
    return ListView(
      children: List.generate(homes.length, (index) {
        return ListTile(
          onLongPress: () {
            setState(() {
              homes[index].selected = true;
              selectingMode = true;
            });
          },
          onTap: () {
            setState(() {
              if (selectingMode) {
                homes[index].selected = !homes[index].selected;
                log(homes[index].selected.toString());
              }
            });
          },
          selected: homes[index].selected,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Text(
                homes[index].name,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          trailing: (selectingMode)
              ? ((homes[index].selected)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank))
              : null,
        );
      }),
    );
  }

  Widget bodyHomepageItems() {
    List<Item> items = []; // Wip: Collect all objects in homes
    return ListView(
      children: List.generate(items.length, (index) {
        return ListTile(
          onLongPress: () {
            setState(() {
              items[index].selected = true;
              selectingMode = true;
            });
          },
          onTap: () {
            setState(() {
              if (selectingMode) {
                items[index].selected = !items[index].selected;
                log(items[index].selected.toString());
              }
            });
          },
          selected: items[index].selected,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Text(
                items[index].name,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          trailing: (selectingMode)
              ? ((items[index].selected)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank))
              : null,
        );
      }),
    );
  }

  FFNavigationBar navigationBar(int selectedIndex) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.blue,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        if (index == 0 && index != selectedIndex) {
          setState(() {
            status = 0;
          });
        }
        if (index == 1 && index != selectedIndex) {
          setState(() {
            status = 1;
          });
        }
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.home,
          label: 'Homes',
        ),
        FFNavigationBarItem(
          iconData: Icons.article,
          label: 'Objects',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: navigationBar(status),
      body: status == 0
          ? bodyHomepageHomes()
          : status == 1
              ? bodyHomepageItems()
              : null,
      floatingActionButton: floatingButton(context),
    );
  }
}
