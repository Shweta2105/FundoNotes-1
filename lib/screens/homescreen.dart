import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:fundonotes/screens/createnewnotes.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends BaseScreenState {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        backgroundColor: HexColor('#FFFFFF'),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.grid_view,
                color: Colors.black,
              )),
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
      body: const Center(
        child: Text("Press below to create new notes"),
      ),
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
                      MaterialPageRoute(builder: (_) => CreateNewNote()));
                },
                icon: Image.asset("assets/images/addIcon.jpg"))),
      ),
    );
  }
}
