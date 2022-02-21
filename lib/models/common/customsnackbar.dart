import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  final String message;

  CustomSnackbar(this.message);
  static show(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
      duration: Duration(seconds: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}
