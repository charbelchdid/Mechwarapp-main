// To parse this JSON data, do
//
//     final activitiesParent = activitiesParentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ActivitiesParent activitiesParentFromJson(String str) => ActivitiesParent.fromJson(json.decode(str));

String activitiesParentToJson(ActivitiesParent data) => json.encode(data.toJson());

class ActivitiesParent {
  bool success;
  List<Activity> data;

  ActivitiesParent({
    required this.success,
    required this.data,
  });

  factory ActivitiesParent.fromJson(Map<String, dynamic> json) => ActivitiesParent(
    success: json["success"],
    data: List<Activity>.from(json["data"].map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Activity {
  String rowguid;
  String title;
  String category;
  String description;
  String details;
  double longitude;
  double latitude;
  String startingTime;
  String endingTime;
  String location;
  String region;
  String picture;
  String type;
  String guideName;
  String guideProfile;
  double guideRating;
  String guideInstaProfile;
  bool isReserved;

  Activity({
    required this.rowguid,
    required this.title,
    required this.category,
    required this.description,
    required this.details,
    required this.longitude,
    required this.latitude,
    required this.startingTime,
    required this.endingTime,
    required this.location,
    required this.region,
    required this.picture,
    required this.type,
    required this.guideName,
    required this.guideProfile,
    required this.guideRating,
    required this.guideInstaProfile,
    required this.isReserved,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    rowguid: json["rowguid"],
    title: json["title"],
    category: json["category"],
    description: json["description"],
    details: json["details"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    startingTime: json["starting_time"],
    endingTime: json["ending_time"],
    location: json["location"],
    region: json["region"],
    picture: json["picture"],
    type: json["type"],
    guideName: json["guide_name"],
    guideProfile: json["guide_profile"],
    guideRating: json["guide_rating"]?.toDouble(),
    guideInstaProfile: json["guide_insta_profile"],
    isReserved: json["is_reserved"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowguid,
    "title": title,
    "category": category,
    "description": description,
    "details": details,
    "longitude": longitude,
    "latitude": latitude,
    "starting_time": startingTime,
    "ending_time": endingTime,
    "location": location,
    "region": region,
    "picture": picture,
    "type": type,
    "guide_name": guideName,
    "guide_profile": guideProfile,
    "guide_rating": guideRating,
    "guide_insta_profile": guideInstaProfile,
    "is_reserved": isReserved,
  };
}
