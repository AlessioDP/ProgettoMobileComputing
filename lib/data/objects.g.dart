// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data()
    ..homes = (json['homes'] as List)
        ?.map((e) =>
            e == null ? null : ListedObject.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'homes': instance.homes?.map((e) => e?.toJson())?.toList(),
    };

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home(
    json['name'] as String,
    (json['childs'] as List)
        ?.map((e) =>
            e == null ? null : ListedObject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'name': instance.name,
      'childs': instance.childs?.map((e) => e?.toJson())?.toList(),
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['name'] as String,
    (json['childs'] as List)
        ?.map((e) =>
            e == null ? null : ListedObject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['description'] as String,
    json['quantity'] as int,
    json['place'] as bool,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'childs': instance.childs,
      'description': instance.description,
      'quantity': instance.quantity,
      'place': instance.place,
    };

ListedObject _$ListedObjectFromJson(Map<String, dynamic> json) {
  return ListedObject(
    json['name'] as String,
    (json['childs'] as List)
        ?.map((e) =>
            e == null ? null : ListedObject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedObjectToJson(ListedObject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'childs': instance.childs,
    };
