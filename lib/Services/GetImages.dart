import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/images_model.dart';
import '../urls/urls.dart';

Future<List<Images>?> getImages(String item,String rowguid) async {
  try {
    String url = await GetUrls().getImages(item,rowguid);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var list1=utf8.decode(response.bodyBytes);
      ImageParent _list = imageParentFromJson(list1);
      return _list.data;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}