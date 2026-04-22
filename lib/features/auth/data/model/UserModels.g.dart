// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModels _$UserModelsFromJson(Map<String, dynamic> json) => UserModels(
  email: json['email'] as String,
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  token: json['accessToken'] as String?,
);

Map<String, dynamic> _$UserModelsToJson(UserModels instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'accessToken': instance.token,
    };
