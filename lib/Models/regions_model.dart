// To parse this JSON data, do
//
//     final regions = regionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Regions regionsFromJson(String str) => Regions.fromJson(json.decode(str));

String regionsToJson(Regions data) => json.encode(data.toJson());

class Regions {
  bool success;
  List<Datum> data;

  Regions({
    required this.success,
    required this.data,
  });

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String rowGuid;
  String name;
  String arabicName;
  String image;

  Datum({
    required this.rowGuid,
    required this.name,
    required this.arabicName,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    rowGuid: json["rowguid"],
    name: json["name"],
    arabicName: json["arabic_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowGuid,
    "name": name,
    "arabic_name": arabicName,
    "image": image,
  };
}