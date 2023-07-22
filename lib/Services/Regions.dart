import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/regions_model.dart';
import '../urls/urls.dart';

class RegionsAPI {
  Future<Regions?> getRegions() async {
    try {
      String url = await GetUrls().getRegionsAPI();
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        Regions _list = regionsFromJson(list1);
        print(_list.data[0].name);
        return _list;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}