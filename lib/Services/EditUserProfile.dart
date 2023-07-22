import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GetUserRowg.dart';

void editUser(String name, String email, String profile,String rowg) async {
  final url = 'https://come-to-lebanon.onrender.com/api/users/edit?rowguid=$rowg';

  final body = {
    "name": '$name',
    "email": "$email",
    "profile": "$profile"
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));

  if (response.statusCode == 200) {
    updateUserDataLocally(email, name);
    // API call successful
    print('User edited successfully');
  } else {
    // API call failed
    print('Failed to edit user. Error code: ${response.statusCode}');
  }
}
