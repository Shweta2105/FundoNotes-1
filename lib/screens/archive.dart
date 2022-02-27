import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundonotes/api/firebasemanager.dart';
import 'package:fundonotes/models/common/constants.dart';
import 'package:fundonotes/models/notes.dart';
import 'package:fundonotes/screens/createnewnotes.dart';
import 'package:fundonotes/screens/homescreen.dart';
import 'package:fundonotes/view/navigationdrawer.dart';
import 'package:fundonotes/view/notecard.dart';

class Archive extends StatelessWidget {
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );

  Widget customSearchBar = const Text("");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: whitebackcolor),
        automaticallyImplyLeading: true,
        backgroundColor: whitebackcolor,
        title: Text('Archive'),
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
                    onPressed: () => NavigationDrawer(),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Search your notes",
                      ),
                    ),
                  ),
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
      body: FutureBuilder<List<Notes>>(
          future: FirebaseManager1.archiveNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("ConnectionState.waiting state");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount:
                    filterNotes.isEmpty ? noteList.length : filterNotes.length,
                itemBuilder: (BuildContext context, int index) {
                  // if(index%10 == 0)

                  Notes note = filterNotes.isEmpty
                      ? noteList[index]
                      : filterNotes[index];

                  return NoteCard(note: note);
                });
          }),
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                icon: Text('Home'))),
      ),
    );
  }
}
