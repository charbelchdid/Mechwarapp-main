import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Models/user_info_model.dart';
import '../provider/LoadProvider.dart';
import '../urls/urls.dart';


  Future<void> getUserRow(BuildContext context) async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    try {
      String url = await GetUrls().getUserRowguidAPI();
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        UserInfo _list = userInfoFromJson(list1);
        provider.userRowguid=_list.payload.rowguid;
      }
    } catch (e) {
      log(e.toString());
    }
  }
