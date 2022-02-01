import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage

  Future<String> uploadImage(String childname, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childname).child(_auth.currentUser!.uid);
    UploadTask _uploadtask = ref.putData(file);

    TaskSnapshot taskSnapshot = await _uploadtask;
    //download image url
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
