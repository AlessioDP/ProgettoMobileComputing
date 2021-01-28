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
}

@JsonSerializable()
class Item {
  String name;
  int quantity;
  String description;

  @JsonKey(ignore: true)
  String homeName;

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
