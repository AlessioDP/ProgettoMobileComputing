import 'package:SearchIt/data/database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objects.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  List<Home> homes = [];

  Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  static ListedObject getObjectAtIndex(List<int> indexes) {
    ListedObject ret = data.homes[indexes[0]];
    for (int c = 1; c < indexes.length; c++) {
      ret = ret.getChilds()[indexes[c]];
    }
    return ret;
  }

  static ListedObject getParentOfIndex(List<int> indexes) {
    ListedObject ret = data.homes[indexes[0]];
    for (int c = 1; c < indexes.length - 1; c++) {
      ret = ret.getChilds()[indexes[c]];
    }
    return ret;
  }

  static List<Map> getAllItems() {
    List<Map> items = [];

    for (int home = 0; home < data.homes.length; home++) {
      for (int item = 0; item < data.homes[home].childs.length; item++) {
        _insertObjects([home, item], data.homes[home].childs[item], items);
      }
    }
    return items;
  }

  static void _insertObjects(List<int> indexes, Item item, List items) {
    if (item.isPlace()) {
      for (int c = 0; c < item.childs.length; c++) {
        _insertObjects([...indexes, c], item.childs[c], items);
      }
    } else {
      items.add({"index": indexes, "item": item});
    }
  }

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
class Home implements ListedObject {
  String name;
  String description;
  String color;
  List<Item> childs = [];

  Home.empty();
  Home(this.name, this.description, this.color, this.childs);

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getDescription() {
    return this.description;
  }

  void setDescription(String description) {
    this.description = description;
  }

  String getColor() {
    return this.color;
  }

  void setColor(String color) {
    this.color = color;
  }

  List<ListedObject> getChilds() {
    return childs;
  }

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
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
class Item implements ListedObject {
  String name;
  String description;
  String color;
  List<Item> childs = [];
  int quantity = 1;
  bool place = false;

  Item.empty();
  Item(this.name, this.description, this.color, this.childs, this.quantity,
      this.place);

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getDescription() {
    return this.description;
  }

  void setDescription(String description) {
    this.description = description;
  }

  String getColor() {
    return this.color;
  }

  void setColor(String color) {
    this.color = color;
  }

  List<ListedObject> getChilds() {
    return childs;
  }

  int getQuantity() {
    return this.quantity;
  }

  void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  bool isPlace() {
    return this.place;
  }

  void setPlace(bool place) {
    this.place = place;
  }

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

class ListedObject {
  String getName() {}
  void setName(String name) {}

  String getDescription() {}
  void setDescription(String description) {}

  String getColor() {}
  void setColor(String color) {}

  List<ListedObject> getChilds() {}
}
