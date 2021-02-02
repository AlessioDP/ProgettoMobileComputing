import 'package:SearchIt/data/database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objects.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  List<ListedObject> homes = [];

  Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  List<Home> getHomes(int sortNumber) {
    List<Home> homeSorted = this.homes;
    var backupList = homes;
    if (sortNumber == 0) {
      homeSorted.sort((a, b) => a.name.compareTo(b.name));
    }
    if (sortNumber == 1) {
      homeSorted = backupList.reversed.toList();
    }
    return homeSorted;
  }
}

@JsonSerializable(explicitToJson: true)
class Home extends ListedObject {
  //@JsonKey(ignore: true)
  //bool selected = false;

  //List<Item> items = [];

  //bool container = false;
  //List<Place> places = [];

  Home.empty() : super.empty();

  Home(String name, List<ListedObject> childs) : super(name, childs);
/*
  @override
  bool isSelected() {
    return selected;
  }

  @override
  bool setSelected(bool sel) {
    this.selected = sel;
  }*/

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
/*
  static List<String> getHomesNames() {
    List<String> names = [];
    data.homes.forEach((home) {
      names.add(home.name);
    });
    return names;
  }

  static List<Home> getSelectedHomes() {
    return data.homes.where((home) => home.selected == true).toList();
  }

  static bool onlyOneSelected() {
    return (getSelectedHomes().length == 1);
  }

  static void removeAllSelectedHomes() {
    data.homes.removeWhere((home) => home.selected == true);
  }*/
}
/*
@JsonSerializable()
class Place {
  String name;
  String description;
  List<Item> items = [];
  List<Place> places = [];

  Place(this.name, this.description);
  Place.empty();

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  static Map<String, List<String>> getPlacesNames() {
    Map<String, List<String>> _placesNames;
    List<String> names = [];
    data.homes.forEach((home) {
      names = [];
      if (home.places.isNotEmpty) {
        home.places.forEach((place) {
          names.add(place.name);
        });
      }
      _placesNames[home.name] = names;
    });
    return _placesNames;
  }

  static List<String> getPlacesNameFromHome(String homeName) {
    List<String> nomi = [];
    List<Place> places =
        data.homes.where((element) => element.name == homeName).first.places;
    if (places.isNotEmpty) {
      places.forEach((element) {
        nomi.add(element.name);
      });
      return nomi;
    }
    return nomi;
  }
}
*/
@JsonSerializable()
class Item extends ListedObject {
  String description;
  int quantity = 1;
  bool place = false;
  
  Item(String name, List<ListedObject> childs, this.description, this.quantity, this.place) : super(name, childs);
  Item.empty() : super.empty();
/*
  @override
  bool isSelected() {
    return selected;
  }

  @override
  bool setSelected(bool sel) {
    this.selected = sel;
  }
*/

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
/*
  static List<Item> getAllItem(int sorted) {
    List<Item> allItems = [];
    data.homes.forEach((home) {
      allItems.addAll(home.items);
    });

    List<Item> backupList = allItems;

    if (sorted == 0) {
      allItems.sort((a, b) => a.name.compareTo(b.name));
    }
    if (sorted == 1) {
      allItems.sort((a, b) => a.homeName.compareTo(b.name));
    }
    if (sorted == 2) {
      allItems = backupList.reversed.toList();
    }
    return allItems;
  }

  static List<Item> getSelectedItems() {
    return getAllItem(0).where((item) => item.selected == true).toList();
  }

  static bool onlyOneSelected(List<Item> allItems) {
    return getSelectedItems().length == 1;
  }

  Home getHome(String nomeCasa) {
    return data.homes.where((home) => home.name == nomeCasa).first;
  }

  static void removeAllSelectedItems() {
    data.homes.forEach((home) {
      home.items.removeWhere((item) => item.selected == true);
    });
  }
  */
}

@JsonSerializable()
class ListedObject {
  String name;
  List<ListedObject> childs = [];

  ListedObject(this.name, this.childs);
  ListedObject.empty();

  void deleteChild(ListedObject lo) {
    childs.remove(lo);
  }

  factory ListedObject.fromJson(Map<String, dynamic> json) => _$ListedObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ListedObjectToJson(this);
}