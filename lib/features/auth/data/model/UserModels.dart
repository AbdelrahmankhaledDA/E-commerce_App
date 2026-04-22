import 'package:json_annotation/json_annotation.dart';

part 'UserModels.g.dart';

@JsonSerializable()
class UserModels {
  int id;
  String username;
  String email;
  @JsonKey(name: 'accessToken')
  final String? token;
  UserModels({
    required this.email,
    required this.id,
    required this.username,
    this.token,
  });
  factory UserModels.fromJson(Map<String, dynamic> json) =>
      _$UserModelsFromJson(json);
}
