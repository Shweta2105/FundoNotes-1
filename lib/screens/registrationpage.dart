import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:fundonotes/models/common/constants.dart';
import 'package:fundonotes/resources/authmethod.dart';
import 'package:fundonotes/utils/pickimage.dart';
import 'package:fundonotes/utils/usermethod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPage extends BaseScreen {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  RegistrationPageState createState() => new RegistrationPageState();
}

class RegistrationPageState extends BaseScreenState {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode fnameFocus = new FocusNode();
  FocusNode lnameFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();

  bool fnameValid = true;
  bool lnameValid = true;
  bool emailValid = true;
  bool passwordValid = true;
  bool matchPassword = true;
  Uint8List? _image;
  void initState() {
    super.initState();
  }

  _fnameRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(fnameFocus);
    });
  }

  _lnameRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(lnameFocus);
    });
  }

  _emailRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_emailFocus);
    });
  }

  _passwordRequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_passwordFocus);
    });
  }

  void selectProfileImage() async {
    Uint8List im = await PickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  // signUpUser() async {
  //   String result = await AuthMethod.SignupUser(
  //     email: _emailController.text,
  //     username: fnameController.text,
  //     password: _passwordController.text,
  //     file: _image!,
  //   );
  //   if (result == 'success') {
  //     Navigator.pop(context);
  //   } else {
  //     //show snackbar to user

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 10.0,
          title: Text('FundoNotes Registration',
              style: TextStyle(
                color: HexColor('#151B54'),
                fontWeight: FontWeight.w400,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              )),
          centerTitle: true,
        ),
        body: SafeArea(
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraint) {
            return SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraint.maxHeight,
              ),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.greenAccent,
                  Colors.yellowAccent
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: HexColor('#FFFFFF'),
                          elevation: 10,
                          child: SizedBox(
                            height: 40,
                            width: 55,
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                      'assets/images/fundooIcon.jpg'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 55,
                                  backgroundImage: MemoryImage(_image!))
                              : const CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage(
                                      'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'),
                                ),
                          Positioned(
                              bottom: -10,
                              left: 70,
                              child: IconButton(
                                  onPressed: () {
                                    selectProfileImage();
                                  },
                                  icon: const Icon(Icons.add_a_photo)))
                        ],
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                        child: TextField(
                          controller: fnameController,
                          focusNode: fnameFocus,
                          onTap: _fnameRequestFocus,
                          onChanged: (value) {
                            fnameValid = value.length <= 15;
                            // value.length <= 15
                            //     ? fnameValid = true
                            //     : fnameValid = false;
                            setState(() {});
                          },
                          // ignore: unnecessary_new
                          style: new TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: HexColor('#606E74')),
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              errorText:
                                  fnameValid ? null : "Invalid first name",
                              errorStyle: const TextStyle(fontSize: 15),
                              labelStyle: TextStyle(
                                  color: fnameFocus.hasFocus
                                      ? fnameValid
                                          ? Colors.amberAccent
                                          : Colors.red
                                      : HexColor('#658292')),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('#658292'))),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide: fnameFocus.hasFocus
                                    ? const BorderSide(
                                        color: Colors.amber, width: 1.2)
                                    : BorderSide(color: HexColor('#658292')),
                              )),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextField(
                          controller: lnameController,
                          focusNode: lnameFocus,
                          onTap: _lnameRequestFocus,
                          onChanged: (value) {
                            lnameValid = value.length <= 15;

                            setState(() {});
                          },
                          style: new TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: textcolor),
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              errorText:
                                  lnameValid ? null : "Invalid last name",
                              errorStyle: const TextStyle(fontSize: 15),
                              labelStyle: TextStyle(
                                  color: lnameFocus.hasFocus
                                      ? lnameValid
                                          ? Colors.amberAccent
                                          : Colors.red
                                      : HexColor('#658292')),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('#658292'))),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide: lnameFocus.hasFocus
                                    ? const BorderSide(
                                        color: Colors.amber, width: 1.2)
                                    : BorderSide(color: HexColor('#658292')),
                              )),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          onTap: _emailRequestFocus,
                          onChanged: (value) {
                            if (emailRegExp.hasMatch(value)) {
                              emailValid = true;
                            } else {
                              emailValid = false;
                            }
                            setState(() {});
                          },
                          style: new TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: textcolor),
                          decoration: InputDecoration(
                              labelText: 'Email Id',
                              errorText: emailValid ? null : "Invalid email",
                              errorStyle: const TextStyle(fontSize: 15),
                              labelStyle: TextStyle(
                                  color: _emailFocus.hasFocus
                                      ? emailValid
                                          ? Colors.amberAccent
                                          : Colors.red
                                      : HexColor('#658292')),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('#658292'))),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide: _emailFocus.hasFocus
                                    ? const BorderSide(
                                        color: Colors.amber, width: 1.2)
                                    : BorderSide(color: HexColor('#658292')),
                              )),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Container(
                          child: SizedBox(
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              onTap: _passwordRequestFocus,
                              onChanged: (value) {
                                if (passwordRegExp.hasMatch(value)) {
                                  passwordValid = true;
                                } else {
                                  passwordValid = false;
                                }
                                setState(() {});
                              },
                              style: new TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  color: textcolor),
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  errorText:
                                      passwordValid ? null : "Invalid password",
                                  errorStyle: const TextStyle(fontSize: 15),
                                  labelStyle: TextStyle(
                                      color: _passwordFocus.hasFocus
                                          ? passwordValid
                                              ? Colors.amberAccent
                                              : Colors.red
                                          : HexColor('#658292')),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#658292'))),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    borderSide: _passwordFocus.hasFocus
                                        ? const BorderSide(
                                            color: Colors.amber, width: 1.2)
                                        : BorderSide(
                                            color: HexColor('#658292')),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                              textColor: buttoncolorwhite,
                              color: buttoncolorblue,
                              child: Text(
                                'SignUp',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () => UserMethod.signUpUser(
                                  context,
                                  _emailController.text,
                                  fnameController.text,
                                  lnameController.text,
                                  _passwordController.text))),
                      Container(
                          child: Row(
                        children: <Widget>[
                          FlatButton(
                            textColor: buttoncolorblue,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/loginpage');
                              //signup screen
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                    ]),
              ),
            ));
          }),
        ));
  }
}
