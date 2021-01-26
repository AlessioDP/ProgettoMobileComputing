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

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  static List<Item> getSelectedItems(List<Item> allItems) {
    return allItems.where((item) => item.selected == true).toList();
  }

  static bool onlyOneSelected(List<Item> allItems) {
    return getSelectedItems(allItems).length == 1;
  }

  Home getHome(String nomeCasa) {
    return Data().homes.where((home) => home.name == nomeCasa).first;
  }

}
