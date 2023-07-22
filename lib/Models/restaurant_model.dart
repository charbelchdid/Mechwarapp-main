// To parse this JSON data, do
//
//     final restauParent = restauParentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RestauParent restauParentFromJson(String str) => RestauParent.fromJson(json.decode(str));

String restauParentToJson(RestauParent data) => json.encode(data.toJson());

class RestauParent {
  bool success;
  List<Restaurant> data;

  RestauParent({
    required this.success,
    required this.data,
  });

  factory RestauParent.fromJson(Map<String, dynamic> json) => RestauParent(
    success: json["success"],
    data: List<Restaurant>.from(json["data"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Restaurant {
  String rowGuid;
  String rating;
  String menu;
  String description;
  String region;
  double longitude;
  double latitude;
  String name;
  String picture;
  String openingTime;
  String closingTime;
  String type;

  Restaurant({
    required this.rowGuid,
    required this.rating,
    required this.menu,
    required this.description,
    required this.region,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.picture,
    required this.openingTime,
    required this.closingTime,
    required this.type,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    rowGuid: json["rowguid"],
    rating: json["rating"],
    menu: json["menu"],
    description: json["description"],
    region: json["region"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    name: json["name"],
    picture: json["picture"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowGuid,
    "rating": rating,
    "menu": menu,
    "description": description,
    "region": region,
    "longitude": longitude,
    "latitude": latitude,
    "name": name,
    "picture": picture,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "type": type,
  };
}
