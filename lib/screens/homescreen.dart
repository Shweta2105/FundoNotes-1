import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:fundonotes/models/notes.dart';

import 'package:fundonotes/screens/createnewnotes.dart';
import 'package:fundonotes/view/notecard.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool view = false;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference ref = FirebaseFirestore.instance.collection('users');
String? uid;

class _HomeScreenState extends State<HomeScreen> {
  printData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(uid).collection('notes').get();
    print("----------------------------------------------------------");
    snapshot.docs
        .map((doc) => {
              // ignore: avoid_print
              print(doc['title']),
              print(doc['description']),
              print("++++++++++++++++++++++++++++++++++++++++++++++++++"),
            })
        .toList();
    print("++++++++++++++++++++++++++++++++++++++++++++++++++");
  }

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser?.uid;
    printData();
  }

  Widget build(BuildContext context) {
    print("===========================================");
    String? userid = _auth.currentUser?.uid;
    print(userid);
    print("===========================================");
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        backgroundColor: HexColor('#FFFFFF'),
        actions: <Widget>[
          IconButton(
            icon: Icon(view ? Icons.list_rounded : Icons.grid_view_outlined),
            color: Colors.black,
            onPressed: () {
              setState(() {
                view = !view;
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.settings_power,
          //     )),
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: _changeView(),
      //GridviewNotes(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.amber,
        focusColor: Colors.white10,
        hoverColor: Colors.green,
        backgroundColor: Colors.white,
        splashColor: Colors.tealAccent,
        onPressed: () => {},
        child: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CreateNewNote()))
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: Image.asset("assets/images/addIcon.jpg"))),
      ),
    );
  }
}

class GridviewNotes extends StatelessWidget {
  const GridviewNotes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notes>>(
        future: _getAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("ConnectionState.waiting state");
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              Notes note = snapshot.data![index];

              return NoteCard(note: note);
            },
          );
        });
  }
}

class ListDisplay extends StatelessWidget {
  const ListDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notes>>(
        future: _getAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("ConnectionState.waiting state");
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Notes note = snapshot.data![index];

                return NoteCard(note: note);
              });
        });
  }
}

_changeView() {
  if (view == false) {
    return ListDisplay();
  } else {
    return GridviewNotes();
  }
}

Future<List<Notes>> _getAllNotes() async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('users').doc(uid).collection('notes').get();
  print("----------------------------------------------------------");
  List<Notes> notes = snapshot.docs
      .map(
        (doc) => Notes(
            title: doc['title'],
            description: doc['description'],
            id: doc['id']),
      )
      .toList();

  return notes;
}
