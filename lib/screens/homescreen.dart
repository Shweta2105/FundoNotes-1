import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundonotes/api/firebasemanager.dart';
import 'package:fundonotes/api/sqlmanager.dart';
import 'package:fundonotes/models/common/constants.dart';
import 'package:fundonotes/models/notes.dart';
import 'package:fundonotes/resources/notificationplugins.dart';
import 'package:fundonotes/screens/createnewnotes.dart';
import 'package:fundonotes/view/navigationdrawer.dart';
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
List<Notes> noteList = [];
List<Notes> filterNotes = [];

final ScrollController _scrollController = ScrollController();

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPageLoading = false, hasMoreNotes = true;

  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );
  Widget customSearchBar = const Text("");

  pageFetch() async {
    if (hasMoreNotes == false) {
      return;
    }
    setState(() {
      isPageLoading = true;
    });
    List<Notes> temp = await FirebaseManager1.fetchNotes();
    if (temp.length < 10) {
      hasMoreNotes = false;
    }
    if (temp.isNotEmpty) {
      noteList.addAll(temp);
    }
    setState(() {
      isPageLoading = !isPageLoading;
    });
  }

  fetchMorePage() async {
    print("--------------in more page method------------------");
    if (hasMoreNotes == false) {
      print("no more data");
      return;
    }

    setState(() {
      isPageLoading = true;
    });

    List<Notes> temp = await FirebaseManager1.fetchMoreNotes();

    noteList.addAll(temp);
    print(noteList.length);
    if (temp.length < 10) {
      hasMoreNotes = false;
    }
    setState(() {
      isPageLoading = false;
    });
  }

  onNotificationInLowerVersions(receivedNotification) {}

  onNotificationClick(payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser?.uid;
    pageFetch();
    configureScrollController();
    notificationPlugins.setListenerForLowerVersions(onNotificationClick);
    notificationPlugins.setOnNotificationClick(onNotificationClick);
  }

  noteFetch() {
    noteList;
  }

  configureScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isPageLoading) {
        print(".....................................................");
        fetchMorePage();
        print("---------------${noteList.length}-------------");
        print("============done==========");
      }
    });
  }

  Widget build(BuildContext context) {
    noteFetch();
    print("===========================================");
    String? userid = _auth.currentUser?.uid;
    print(userid);
    print("===========================================");
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: whitebackcolor),
        automaticallyImplyLeading: true,
        backgroundColor: whitebackcolor,
        title: customSearchBar,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 12),
            height: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: whitebackcolor,
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
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    color: Colors.black.withOpacity(0.7),
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  ),
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
      drawer: const NavigationDrawer(),
      body: //_changeView(),
          //GridviewNotes(),
          ListDisplay(),
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
        // future: _getAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        print("ConnectionState.waiting state");
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
        // future: noteList,
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        print("ConnectionState.waiting state");
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          controller: _scrollController,
          itemCount: filterNotes.isEmpty ? noteList.length : filterNotes.length,
          itemBuilder: (BuildContext context, int index) {
            // if(index%10 == 0)

            Notes note =
                filterNotes.isEmpty ? noteList[index] : filterNotes[index];

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
