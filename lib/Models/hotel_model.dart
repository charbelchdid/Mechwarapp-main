// To parse this JSON data, do
//
//     final hotelParent = hotelParentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HotelParent hotelParentFromJson(String str) => HotelParent.fromJson(json.decode(str));

String hotelParentToJson(HotelParent data) => json.encode(data.toJson());

class HotelParent {
  bool success;
  List<Hotel> data;

  HotelParent({
    required this.success,
    required this.data,
  });

  factory HotelParent.fromJson(Map<String, dynamic> json) => HotelParent(
    success: json["success"],
    data: List<Hotel>.from(json["data"].map((x) => Hotel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Hotel {
  String rowGuid;
  String rating;
  String website;
  String description;
  String region;
  double longitude;
  double latitude;
  String name;
  String picture;
  String openingTime;
  String closingTime;
  String services;

  Hotel({
    required this.rowGuid,
    required this.rating,
    required this.website,
    required this.description,
    required this.region,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.picture,
    required this.openingTime,
    required this.closingTime,
    required this.services,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    rowGuid: json["rowguid"],
    rating: json["rating"],
    website: json["website"],
    description: json["description"],
    region: json["region"],
    longitude: json["longitude"]*1.0,
    latitude: json["latitude"]*1.0,
    name: json["name"],
    picture: json["picture"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    services: json["services"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowGuid,
    "rating": rating,
    "website": website,
    "description": description,
    "region": region,
    "longitude": longitude,
    "latitude": latitude,
    "name": name,
    "picture": picture,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "services": services,
  };
}
