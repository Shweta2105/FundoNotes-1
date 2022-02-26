// ignore: file_names
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/api/firebasemanager.dart';
import 'package:fundonotes/api/sqlmanager.dart';
import 'package:fundonotes/models/common/constants.dart';
import 'package:fundonotes/models/notes.dart';
import 'package:fundonotes/resources/notificationplugins.dart';
import 'package:fundonotes/screens/homescreen.dart';

class EditNote extends StatefulWidget {
  Notes note;

  // String? id;

  //final DocumentReference reference;

  EditNote({Key? key, required this.note
      // required this.id,
      })
      : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  String noteId = '';
  String title = '';
  String description = '';
  bool edit = false;

  //String? uid;

  @override
  Widget build(BuildContext context) {
    noteId = widget.note.id!;
    title = widget.note.title!;
    description = widget.note.description!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              FirebaseManager1.updateData(
                  docId: noteId, title: title, description: description);
              notificationPlugins.showNotification('new note created at ');

              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.push_pin,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notification_add,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.archive,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: new TextStyle(
                  fontStyle: FontStyle.normal, fontSize: 15, color: textcolor),
              initialValue: widget.note.title,
              enabled: edit,
              onChanged: (value) {
                title = value;
              },
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: InputBorder.none,
                ),
                style: new TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: textcolor),
                initialValue: widget.note.description,
                enabled: edit,
                onChanged: (value) {
                  description = value;
                },
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.color_lens_outlined)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                      icon: Icon(Icons.edit))
                ]),
            IconButton(
              onPressed: () async {
                print("---------------------------------------------");
                print("${widget.note.id}");
                print("${widget.note.title}");
                print("${widget.note.description}");
                print("going to delete query");
                await FirebaseManager1.deleteData(docId: widget.note.id!);

                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  update() async {
    final note = widget.note.copy(title: title, description: description);
    print("--------------inside-------------");
    print('${note}');
    await SqlManager.instance.updateNotes(note);
  }
}
