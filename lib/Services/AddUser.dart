import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/LoadProvider.dart';
import '../select_region_screen/select_region_screen_widget.dart';
import 'GetUserRowg.dart';

void addUser(String name, String email, String photo, BuildContext context) async {
  var url = Uri.parse('https://come-to-lebanon.onrender.com/api/users/');
  final body = jsonEncode({
    "name": "$name",
    "email": "$email",
    "profile": "https://csp-aub.s3.amazonaws.com/Images/profile.jpg"
  });
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.post(url, headers: headers, body: body);
  final provider = Provider.of<LoadProvider>(context, listen: false);
  if (response.statusCode == 201) {
    saveUserDataLocally(email,name);

      provider.getUserInfo(0,context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const SelectRegionScreenWidget()));

    print('User added successfully!');
  } else {
    print('Failed to add user. Error: ${response.statusCode}');
  }
}