// To parse this JSON data, do
//
//     final placesParent = placesParentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlacesParent placesParentFromJson(String str) => PlacesParent.fromJson(json.decode(str));

String placesParentToJson(PlacesParent data) => json.encode(data.toJson());

class PlacesParent {
  bool success;
  List<Place> data;

  PlacesParent({
    required this.success,
    required this.data,
  });

  factory PlacesParent.fromJson(Map<String, dynamic> json) => PlacesParent(
    success: json["success"],
    data: List<Place>.from(json["data"].map((x) => Place.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Place {
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
  String category;

  Place({
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
    required this.category,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
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
    category: json["type"],
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
    "type": category,
  };
}
