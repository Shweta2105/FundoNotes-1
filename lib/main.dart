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
    initialRoute: '/loginpage',
    routes: {
      '/loginpage': (context) => LoginPage(),
      '/registrationpage': (context) => RegistrationPage(),
      '/homescreen': (context) => HomeScreen(),
      'creatnewnotes': (context) => CreateNewNote(),
    },
  ));
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Fundo Notes",
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const MyHomePage(
//         title: ' Fundo Notes',
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;
