import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fundonotes/api/networkmanager.dart';
import 'package:fundonotes/models/common/styles.dart';
import 'package:fundonotes/models/user.dart';
import 'package:fundonotes/resources/authmethod.dart';
import 'package:http/http.dart';

class UserMethod {
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // TextEditingController fnameController = TextEditingController();
  // TextEditingController lnameController = TextEditingController();

  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode fnameFocus = new FocusNode();
  FocusNode lnameFocus = new FocusNode();

  Uint8List? _image;

  void loginUser(BuildContext context, String email, String password) async {
    String result =
        await AuthMethod.loginUser(email: email, password: password);
    //Navigator.pushNamed(context, '/homescreen');

    if (result == 'success') {
      Navigator.pushNamed(context, '/homescreen');
      //snackbar
      CustomSnackbar.show(context, "Login Successfull...!");
    } else {
      //snackbar
      CustomSnackbar.show(context, "Login Failed... Check Id and password");
    }
  }

  static Future<User> signUpUser(BuildContext context, String email,
      String firstname, String lastname, String password) async {
    //This FireBase
    // String result = await AuthMethod.SignupUser(
    //   email: _emailController.text,
    //   username: fnameController.text,
    //   password: _passwordController.text,
    //   file: _image!,
    // );
    // if (result == 'success') {
    //   Navigator.pop(context);
    //   CustomSnackbar.show(context, 'SignUp successful...!!');
    // } else {
    //   //show snackbar to user
    //   CustomSnackbar.show(context, 'SignUp failed....try again');
    // }
    //this Network code

    User networkuser =
        await NetworkManager.registration(email, firstname, lastname, password);

    print("success");
    print(
        "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999");
    Navigator.pop(context);

    return networkuser;
  }
}
