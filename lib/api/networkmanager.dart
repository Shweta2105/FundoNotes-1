import 'dart:convert';

import 'package:fundonotes/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkManager {


  static registration(
      String email, String firstname, String lastname, String password) async {
    String endPointUrl = "http://localhost:8080/api/auth/registration";
    final response = await http.post(
      Uri.parse(endPointUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'firstName': firstname,
        'lastName': lastname,
        'password': password
      }),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("4444444444444   registration failed   444444444444444");
    }
  }
}
