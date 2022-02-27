// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/screens/createnewnotes.dart';
import 'package:fundonotes/screens/homescreen.dart';
import 'package:fundonotes/screens/loginpage.dart';
import 'package:fundonotes/screens/registrationpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseAuth _auth = FirebaseAuth.instance;
  // User? loggedInUser;

  // final user = _auth.currentUser;
  // if (user != null) {
  //   loggedInUser = user;
  //   print("---------------${loggedInUser}----------------");
  // }

  runApp(MaterialApp(
    home: LoginPage(),
    title: "Fundo Notes",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/homescreen',
    //'/loginpage',
    routes: {
      '/loginpage': (context) => LoginPage(),
      '/registrationpage': (context) => RegistrationPage(),
      '/homescreen': (context) => HomeScreen(),
      'creatnewnotes': (context) => CreateNewNote(),
    },
  ));
}
