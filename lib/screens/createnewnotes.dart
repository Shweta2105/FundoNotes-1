import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';

class CreateNewNote extends BaseScreen {
  @override
  CreateNewNote_state createState() => new CreateNewNote_state();
}

class CreateNewNote_state extends BaseScreenState {
  TextEditingController titleController = new TextEditingController();
  FocusNode titleFocus = new FocusNode();
  @override
  void initState() {
    titleController = TextEditingController();

    super.initState();
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
        backgroundColor: Colors.blueGrey,
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
          padding: EdgeInsets.all(10),
          child: TextField(
            focusNode: titleFocus,
            onTap: _titleRequestFocus,
          )),
    );
  }
}
