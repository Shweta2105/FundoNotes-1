import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final backcolor = Colors.lightBlueAccent;

final titlecolor = HexColor('#151B54');

final whitebackcolor = HexColor('#FFFFFF');

final textcolor = HexColor('#606E74');

const buttoncolorwhite = Colors.white;

const buttoncolorblue = Colors.blue;

RegExp emailRegExp = new RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp passwordRegExp =
    new RegExp(r"^(?=.*?[0-9a-zA-Z])[0-9a-zA-Z]*[@#$%!][0-9a-zA-Z]*$");
