import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/api/firebasemanager.dart';
import 'package:fundonotes/api/sqlmanager.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:fundonotes/models/notes.dart';
import 'package:fundonotes/resources/notificationplugins.dart';
import 'package:fundonotes/screens/homescreen.dart';
import 'package:fundonotes/view/textformwidget.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateNewNote extends BaseScreen {
  @override
  CreateNewNote_state createState() => new CreateNewNote_state();
}

class CreateNewNote_state extends BaseScreenState {
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();
  FocusNode titleFocus = new FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;
  //String? userId = _auth.currentUser!.uid;

  String? uid;

  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('users');

  // uploadData() async {
  //   // String noteId = _notesCollection;
  //   String uid = _auth.currentUser!.uid;

  //   print(uid);
  //   print(
  //       "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  //   DocumentReference<Map<String, dynamic>> noteDoc =
  //       _notesCollection.doc(uid).collection('notes').doc();
  //   Map<String, dynamic> data1 = <String, dynamic>{
  //     'id': noteDoc.id,
  //     'title': titleController.text,
  //     'description': bodyController.text,
  //     'created': DateTime.now(),
  //   };
  //   noteDoc.set(data1);
  //   String noteid = noteDoc.id;
  //   print(noteid);
  // }

  addNote() async {
    final note = Notes(
        title: titleController.text,
        description: bodyController.text,
        dateTime: DateTime.now());

    await SqlManager.instance.insertNewNote(note);
  }

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
    titleController = TextEditingController();
  }

  _titleRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(titleFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              var title = titleController.text;
              var notes = bodyController.text;
              if (title.isEmpty && notes.isEmpty) {
                print('Notes required');
                Navigator.pop(context);
              } else {
                FirebaseManager1.uploadData(title: title, description: notes);
                notificationPlugins.showNotification('new note created at ');

                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.push_pin,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notification_add,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.archive,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
                child: TextFormWidget(
              controller: titleController,
              hint: 'Title',
            )),
            Expanded(
              child: Container(
                child: TextFormWidget(
                  controller: bodyController,
                  hint: 'Description',
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.color_lens_outlined)),
          ],
        ),
      ),
    );
  }
}
