import 'dart:convert';

import 'package:fundonotes/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkManager {
  static registration(
      String email, String firstname, String lastname, String password) async {
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");

    String endPointUrl = "http://10.0.2.2:8080/api/auth/registration";
    print(Uri.parse(endPointUrl));
    final response = await http.post(
      Uri.parse(endPointUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'firstName': firstname,
        'lastName': lastname,
        'password': password
      }),
    );
    print("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("checking....... 200");
    } else if (response.statusCode == 201) {
      print("Inside if..");
      // return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("4444444444444   registration failed   444444444444444");
    }
  }

  static Future<bool> login(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    print("//////////// inside login ///////////");
    String endPointUrl = "http://10.0.2.2:8080/api/auth/authenticate";

    print(endPointUrl);

    http.Response response = await http.post(
      Uri.parse(endPointUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
      }),
    );
    print("llllllllllllll response body lllllllllllllllllllllllllll");
    print(response.body);

    if (response.statusCode == 200) {
      print("checking....... 200");
      var jsonData = jsonDecode(response.body);

      String token = jsonData["token"];

      pref.setString("token", token);
      return true;
    }
    return false;

    //take token in shared preference
  }
}
