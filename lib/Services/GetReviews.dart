import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:c_s_p_app/Models/comments_model.dart';
import 'package:http/http.dart' as http;
import '../Models/region_places_models.dart';
import '../urls/urls.dart';


  Future<List<Comment>?> getReviews(String type, String rowguid) async {
    try {
      String url = await GetUrls().getReviewsAPI(type, rowguid);
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        CommentParent _list = commentParentFromJson(list1);
        return _list.data;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

Future<void> postReview(String user_rowguid, int rating, String comment, String item_rowguid,String item) async {
  var url = Uri.parse('https://come-to-lebanon.onrender.com/api/reviews');

  var body = jsonEncode({
    "user_rowguid": "$user_rowguid",
    "rating": rating,
    "comment": "$comment",
    "item_rowguid": "${item_rowguid}",
    "item": "$item"
  });

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  if (response.statusCode == 201) {
    print('Review posted successfully!');
  } else {
    print('Failed to post the review. Error: ${response.statusCode}');
  }
}

Future<void> deleteReview(String rowg) async {
  var url = Uri.parse('https://come-to-lebanon.onrender.com/api/reviews?rowguid=$rowg');

  var response = await http.delete(url);

  if (response.statusCode == 200) {
    print('Review deleted successfully!');
  } else {
    print('Failed to delete the review. Error: ${response.statusCode}');
  }
}

