import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/markers_model.dart';
import '../urls/urls.dart';

Future<List<Mark>?> getMarkers() async {
    try {
      String url = await GetUrls().getMarkersAPI();
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        MarkersParent _list = markersParentFromJson(list1);
        return _list.data;
      }
    } catch (e) {
      log(e.toString());
    }
  }