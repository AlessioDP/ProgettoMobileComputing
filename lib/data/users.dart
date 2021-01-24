import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class LoggedUser {
  String email;
  //list of home
  //List<Homes> homes; //One to many
  //List<SObject> objects;
  //list of all objects or map with key 'home'. idk

  LoggedUser.empty();

  LoggedUser(this.email);

  factory LoggedUser.fromJson(Map<String, dynamic> json) => _$LoggedUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedUserToJson(this);
}
