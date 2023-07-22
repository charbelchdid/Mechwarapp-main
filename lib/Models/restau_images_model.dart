// To parse this JSON data, do
//
//     final restauImages = restauImagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RestauImages> restauImagesFromJson(String str) => List<RestauImages>.from(json.decode(str).map((x) => RestauImages.fromJson(x)));

String restauImagesToJson(List<RestauImages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestauImages {
  RestauImages({
    required this.rowGuid,
    required this.image,
    required this.item,
    required this.itemRowGuid,
  });

  String rowGuid;
  String image;
  String item;
  String itemRowGuid;

  factory RestauImages.fromJson(Map<String, dynamic> json) => RestauImages(
    rowGuid: json["rowguid"],
    image: json["image"],
    item: json["item"],
    itemRowGuid: json["itemRowGuid"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowGuid,
    "image": image,
    "item": item,
    "itemRowGuid": itemRowGuid,
  };
}