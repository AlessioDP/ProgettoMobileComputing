// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data()
    ..homes = (json['homes'] as List)
        ?.map(
            (e) => e == null ? null : Home.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'homes': instance.homes?.map((e) => e?.toJson())?.toList(),
    };

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home(
    json['name'] as String,
  )
    ..items = (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..places = (json['places'] as List)
        ?.map(
            (e) => e == null ? null : Place.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'name': instance.name,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    json['name'] as String,
    json['description'] as String,
  )
    ..items = (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..places = (json['places'] as List)
        ?.map(
            (e) => e == null ? null : Place.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'places': instance.places?.map((e) => e?.toJson())?.toList(),
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['name'] as String,
    json['quantity'] as int,
    json['description'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'description': instance.description,
    };
