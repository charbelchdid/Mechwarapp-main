// To parse this JSON data, do
//
//     final imageParent = imageParentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ImageParent imageParentFromJson(String str) => ImageParent.fromJson(json.decode(str));

String imageParentToJson(ImageParent data) => json.encode(data.toJson());

class ImageParent {
  bool success;
  List<Images> data;

  ImageParent({
    required this.success,
    required this.data,
  });

  factory ImageParent.fromJson(Map<String, dynamic> json) => ImageParent(
    success: json["success"],
    data: List<Images>.from(json["data"].map((x) => Images.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Images {
  String rowGuid;
  String image;
  String item;
  String itemRowGuid;

  Images({
    required this.rowGuid,
    required this.image,
    required this.item,
    required this.itemRowGuid,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    rowGuid: json["rowguid"],
    image: json["image"],
    item: json["item"],
    itemRowGuid: json["itemrowguid"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowGuid,
    "image": image,
    "item": item,
    "itemRowGuid": itemRowGuid,
  };
}
