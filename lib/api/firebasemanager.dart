import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fundonotes/models/notes.dart';

class FirebaseManager1 {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  static QueryDocumentSnapshot? lastDocument;

  //static getAllNotes() {}
  static Future<List<Notes>> fetchNotes() async {
    String? uid = _auth.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .limit(10)
        .get();
    print("----------------------------------------------------------");
    List<Notes> notes = snapshot.docs
        .map(
          (doc) => Notes(
              title: doc['title'],
              description: doc['description'],
              id: doc['id']),
        )
        .toList();
    lastDocument = snapshot.docs.last;

    return notes;
  }

  static Future<List<Notes>> fetchMoreNotes() async {
    String? uid = _auth.currentUser?.uid;
    print("************firebase*************");

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .startAfterDocument(lastDocument!)
        .limit(10)
        .get();
    print("****************query*******************************");
    List<Notes> notes = snapshot.docs
        .map(
          (doc) => Notes(
              title: doc['title'],
              description: doc['description'],
              id: doc['id']),
        )
        .toList();
    print("---------------------${notes.length}---------------------");
    lastDocument = snapshot.docs.last;
    print(lastDocument);
    print(notes);
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
    String? uid = _auth.currentUser?.uid;
    final CollectionReference _noteCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notes');
    DocumentReference _noteRef = _noteCollection.doc(docId);
    await _noteRef.update({'title': title, 'description': description});
    print("update method####################################");
  }
}
