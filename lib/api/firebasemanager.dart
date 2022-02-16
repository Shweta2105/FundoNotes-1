import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fundonotes/models/notes.dart';

class FirebaseManager1 {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  static final CollectionReference _noteCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('notes');

  static String? uid;

  //static getAllNotes() {}
  Future<List<Notes>> _getAllNotes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _userCollection.doc(uid).collection('notes').get();
    print("----------------------------------------------------------");
    List<Notes> notes = snapshot.docs
        .map(
          (doc) => Notes(
              title: doc['title'], description: doc['description'], id: ''),
        )
        .toList();

    return notes;
  }

  Future<void> uploadData(
      {required String title, required String description}) async {
    String uid = _auth.currentUser!.uid;
    Map<String, dynamic> data = <String, dynamic>{
      //'uid': loggedInUser,
      'title': title,
      'description': description
    };
    await _userCollection
        .doc(uid)
        .collection('notes')
        .add(data)
        .whenComplete(() => print("User added notes"))
        .catchError((e) => print(e));
    print(uid);
  }

  static Future<void> deleteData({
    required String docId,
  }) async {
    String userId = _auth.currentUser!.uid;
    await _firestore
        .collection("users")
        .doc(userId)
        .collection('notes')
        .doc(docId)
        .delete();
    print("Inside delete method!!!!!!!!!!!!!!!!!!!!!!!");
  }

  static Future<void> updateData(
      {required String docId,
      required String title,
      required String description}) async {
    DocumentReference _noteRef = _noteCollection.doc(docId);
    await _noteRef.update({'title': title, 'description': description});
    print("update method####################################");
  }
}
