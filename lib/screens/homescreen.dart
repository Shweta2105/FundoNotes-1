import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends BaseScreen {
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_power,
              )),
          CircleAvatar(),
        ],
      ),
      body: const Center(child: Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: const Icon(
            Icons.add_circle,
            color: Colors.blue,
          )),
    );
  }
}
