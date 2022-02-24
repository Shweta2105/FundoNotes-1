import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundonotes/api/firebasemanager.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:fundonotes/models/notes.dart';

import 'package:fundonotes/screens/createnewnotes.dart';
import 'package:fundonotes/view/notecard.dart';

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
var searchString;
TextEditingController searchTextEdittingController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  List<Notes> noteList = [];
  List<Notes> filterNotes = [];
  QueryDocumentSnapshot? lastDocument;
  final ScrollController _scrollController = ScrollController();
  bool pageLoading = false, ifMoreAvailable = true;

  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );
  Widget customSearchBar = const Text("");

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

  pageFetch() async {
    if (ifMoreAvailable == false) {
      return;
    }
    setState(() {
      pageLoading = true;
    });

    List<Notes> temp = await FirebaseManager1.fetchNotes();
    if (temp.length < 10) {
      ifMoreAvailable = false;
    }
    if (temp.isNotEmpty) {
      noteList.addAll(temp);
    }
    setState(() {
      pageLoading = !pageLoading;
    });
  }

  fetchMorePage() async {
    print("--------------in more page method------------------");
    if (ifMoreAvailable == false) {
      print("no more data");
      return;
    }

    setState(() {
      pageLoading = true;
    });

    List<Notes> temp = await FirebaseManager1.fetchMoreNotes();
    print("////////////${temp.length}//////////////////");
    print(noteList.length);
    noteList.addAll(temp);
    print(noteList.length);
    if (temp.length < 10) {
      ifMoreAvailable = false;
    }
  }

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser?.uid;
    printData();
    pageFetch();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !pageLoading) {
        print(".....................................................");
        await fetchMorePage();
        print("---------------${noteList.length}-------------");
        print("============done==========");
      }
    });
  }

  configureScrollListener() {}

  Widget build(BuildContext context) {
    print("===========================================");
    String? userid = _auth.currentUser?.uid;
    print(userid);
    print("===========================================");
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.white10),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white10,
        title: customSearchBar,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 12),
            height: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      color: Colors.black.withOpacity(0.7),
                      onPressed: () {}),
                  SizedBox(
                    width: 0,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Search your notes",
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchString = value.toLowerCase();

                          filterNotes = noteList
                              .where((element) =>
                                  element.title!.contains(searchString))
                              .toList();
                          //noteList = filterNotes;
                        });
                      },
                      controller: searchTextEdittingController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        view ? Icons.list_rounded : Icons.grid_view_outlined),
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
            ),
          ),
        ),
      ),
      body: //_changeView(),
          //GridviewNotes(),
          // FutureBuilder<List<Notes>>(
          //     future: noteList,
          //     builder:
          //         (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         print("ConnectionState.waiting state");
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          ListView.builder(
              controller: _scrollController,
              itemCount:
                  filterNotes.isEmpty ? noteList.length : filterNotes.length,
              itemBuilder: (BuildContext context, int index) {
                // if(index%10 == 0)
                print(
                    "555555555555555555inside listview55-----------------noteList${[
                  index
                ]}");
                print(noteList.length);

                Notes note =
                    filterNotes.isEmpty ? noteList[index] : filterNotes[index];

                return NoteCard(note: note);
              }),
      // }),
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

// class GridviewNotes extends StatelessWidget {
//   const GridviewNotes({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Notes>>(
//         future: _getAllNotes(),
//         builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print("ConnectionState.waiting state");
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2),
//             itemCount: snapshot.data?.length,
//             itemBuilder: (BuildContext context, int index) {
//               Notes note = snapshot.data![index];

//               return NoteCard(note: note);
//             },
//           );
//         });
//   }
// }

// class ListDisplay extends StatelessWidget {
//   const ListDisplay({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Notes>>(
//         future: _getAllNotes(),
//         builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print("ConnectionState.waiting state");
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//               itemCount: snapshot.data?.length,
//               itemBuilder: (BuildContext context, int index) {
//                 List<Notes> noteList = snapshot.data ?? [];
//                 //if(noteList.length)
//                 Notes note = noteList[index];

//                 return NoteCard(note: note);
//               });
//         });
//   }
// }

// _changeView() {
//   if (view == false) {
//     return ListDisplay();
//   } else {
//     return GridviewNotes();
//   }
// }

// Future<List<Notes>> _getAllNotes() async {
//   QuerySnapshot<Map<String, dynamic>> snapshot =
//       await _firestore.collection('users').doc(uid).collection('notes').get();
//   print("----------------------------------------------------------");
//   List<Notes> notes = snapshot.docs
//       .map(
//         (doc) => Notes(
//             title: doc['title'],
//             description: doc['description'],
//             id: doc['id']),
//       )
//       .toList();

//   return notes;
// }
