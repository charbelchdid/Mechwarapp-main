// To parse this JSON data, do
//
//     final markersParent = markersParentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarkersParent markersParentFromJson(String str) => MarkersParent.fromJson(json.decode(str));

String markersParentToJson(MarkersParent data) => json.encode(data.toJson());

class MarkersParent {
  bool success;
  List<Mark> data;

  MarkersParent({
    required this.success,
    required this.data,
  });

  factory MarkersParent.fromJson(Map<String, dynamic> json) => MarkersParent(
    success: json["success"],
    data: List<Mark>.from(json["data"].map((x) => Mark.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Mark {
  String name;
  double longitude;
  double latitude;
  String type;

  Mark({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.type,
  });

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
    name: json["name"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "longitude": longitude,
    "latitude": latitude,
    "type": type,
  };
}
