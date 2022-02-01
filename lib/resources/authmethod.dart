import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fundonotes/resources/storagemethod.dart';

class AuthMethod {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  static Future<String> SignupUser(
      {required String email,
      required String username,
      required String password,
      required Uint8List file}) async {
    String result = "error occured";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(cred.user!.uid);
      String photoUrl = await StorageMethod().uploadImage('profileimage', file);
//add user to database
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'password': password,
        'photoUrl': photoUrl,
      });

      result = "success";
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}
