import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;


import '../Models/hotel_model.dart';
import '../urls/urls.dart';

  Future<List<Hotel>?> getHotels(String rowguid) async {
    try {
      String url = await GetUrls().getHotelsAPI(rowguid);
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var list1=utf8.decode(response.bodyBytes);
        HotelParent _list = hotelParentFromJson(list1);
        return _list.data;
      }
    } catch (e) {
      log(e.toString());
    }
  }
