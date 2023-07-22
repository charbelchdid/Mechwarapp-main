import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/activities_model.dart';
import '../urls/urls.dart';

Future<ActivitiesParent?> getActivities(String rowguid,String user) async {
  try {
    String url = await GetUrls().getActivitiesAPI(rowguid,user);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var list1=utf8.decode(response.bodyBytes);
      ActivitiesParent _list = activitiesParentFromJson(list1);
      return _list;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}