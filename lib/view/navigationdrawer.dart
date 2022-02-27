import 'package:flutter/material.dart';
import 'package:fundonotes/screens/archive.dart';
import 'package:fundonotes/screens/homescreen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      createDrawerHeader(),
      createDrawerBodyItem(
        icon: Icons.lightbulb_outline,
        text: 'Notes',
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      ),
      
      Divider(),
      createDrawerBodyItem(
        icon: Icons.archive_outlined,
        text: 'Archive',
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Archive()));
        },
      ),
    ]));
  }

  Widget createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class createDrawerHeader extends StatelessWidget {
  const createDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: DrawerHeader(
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.zero,
          child: Text("Fundoo Notes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ))),
    );
  }
}
