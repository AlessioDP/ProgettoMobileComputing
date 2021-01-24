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
  @JsonKey(ignore: true)
  bool selected = false;

  Item(this.name, this.quantity);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
