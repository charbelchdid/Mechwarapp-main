
import 'package:meta/meta.dart';
import 'dart:convert';

CommentParent commentParentFromJson(String str) => CommentParent.fromJson(json.decode(str));

String commentParentToJson(CommentParent data) => json.encode(data.toJson());

class CommentParent {
  bool success;
  List<Comment> data;

  CommentParent({
    required this.success,
    required this.data,
  });

  factory CommentParent.fromJson(Map<String, dynamic> json) => CommentParent(
    success: json["success"],
    data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Comment {
  String rowGuid;
  int rating;
  String comment;
  String userRowguid;
  String userName;
  String userProfile;

  Comment({
    required this.rowGuid,
    required this.rating,
    required this.comment,
    required this.userRowguid,
    required this.userName,
    required this.userProfile,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    rowGuid: json["rowguid"],
    rating: json["rating"],
    comment: json["comment"],
    userRowguid: json["user_rowguid"],
    userName: json["user_name"],
    userProfile: json["user_profile"],
  );

  Map<String, dynamic> toJson() => {
    "rowguid": rowGuid,
    "rating": rating,
    "comment": comment,
    "user_rowguid": userRowguid,
    "user_name": userName,
    "user_profile": userProfile,
  };
}
