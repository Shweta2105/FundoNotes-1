import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_database/firebase_database.dart';

class CreateNewNote extends BaseScreen {
  @override
  CreateNewNote_state createState() => new CreateNewNote_state();
}

class CreateNewNote_state extends BaseScreenState {
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();
  FocusNode titleFocus = new FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;
  var loggedInUser;
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<User> getCurrentUser() async {
    final user = await _auth.currentUser;
    loggedInUser = user!.uid;

    return loggedInUser;
  }

  uploadData() async {
    Map<String, dynamic> data = <String, dynamic>{
      'uid': loggedInUser,
      'title': titleController.text,
      'description': bodyController.text
    };
    await _notesCollection
        .add(data)
        .whenComplete(() => print("User added notes"))
        .catchError((e) => print(e));
  }



  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
              uploadData();
              Navigator.pop(context);
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
              child: TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: HexColor('#606E74')),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: TextFormField(
                  controller: bodyController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: new TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: HexColor('#606E74')),
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
