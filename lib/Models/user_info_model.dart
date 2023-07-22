// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  bool success;
  Payload payload;

  UserInfo({
    required this.success,
    required this.payload,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    success: json["success"],
    payload: Payload.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": payload.toJson(),
  };
}

class Payload {
  String rowguid;
  String name;
  String email;
  String profile;

  Payload({
    required this.rowguid,
    required this.name,
    required this.email,
    required this.profile,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    rowguid: json["rowguid"],
    name: json["name"],
    email: json["email"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowguid,
    "name": name,
    "email": email,
    "profile": profile,
  };
}