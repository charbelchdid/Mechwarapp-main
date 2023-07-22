import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/user_info_model.dart';
import '../urls/urls.dart';

class UserInfoAPI {
  Future<UserInfo?> getUserInfo(String rowguid) async {
    try {
      String url = await GetUrls().getUserInfoAPI(rowguid);
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        UserInfo _list = userInfoFromJson(list1);
        return _list;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}