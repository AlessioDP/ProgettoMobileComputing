import 'package:SearchIt/data/database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objects.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  List<Home> homes = [];

  Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Home {
  String name;
  @JsonKey(ignore: true)
  bool selected = false;
  List<Item> items = [];
  List<Place> places = [];

  Home.empty();

  Home(this.name);

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);

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
  }
}

@JsonSerializable()
class Place {
  String name;
  String description;
  List<Item> items = [];

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

@JsonSerializable()
class Item {
  String name;
  int quantity;
  String description;

  @JsonKey(ignore: true)
  String homeName;

  @JsonKey(ignore: true)
  String placeName;

  @JsonKey(ignore: true)
  bool selected = false;

  Item(this.name, this.quantity, this.description);
  Item.empty();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  static List<Item> getAllItem() {
    List<Item> allItems = [];
    data.homes.forEach((home) {
      allItems.addAll(home.items);
    });
    return allItems;
  }

  static List<Item> getSelectedItems() {
    return getAllItem().where((item) => item.selected == true).toList();
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
}
