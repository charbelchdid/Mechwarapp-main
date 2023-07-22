import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/region_places_models.dart';
import '../urls/urls.dart';

class RegionPlacesAPI {
  Future<List<Place>?> getRegionPlaces(String rowguid) async {
    try {
      String url = await GetUrls().getPlacesAPI(rowguid);
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        PlacesParent _list = placesParentFromJson(list1);
        return _list.data;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}