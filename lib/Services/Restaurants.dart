import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../Models/restaurant_model.dart';
import '../urls/urls.dart';

class RestaurantsAPI {
  Future<List<Restaurant>?> getRestaurants(String rowguid) async {
    try {
      String url = await GetUrls().getRestaurantsAPI(rowguid);
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        RestauParent _list = restauParentFromJson(list1);
        return _list.data;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}