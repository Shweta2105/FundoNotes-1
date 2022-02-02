import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends BaseScreen {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends BaseScreenState {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // User? loggedInUser;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

  bool emailValid = true;
  bool passwordValid = true;
  RegExp emailRegExp = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordRegExp =
      new RegExp(r"^(?=.*?[0-9a-zA-Z])[0-9a-zA-Z]*[@#$%!][0-9a-zA-Z]*$");

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    //getData();
  }

  // void getCurrentUser() {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     loggedInUser = user;
  //     print(loggedInUser);
  //   }
  // }

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 10.0,
        title: Text('FundoNotes Login',
            style: TextStyle(
              color: HexColor('#151B54'),
              fontWeight: FontWeight.w400,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            )),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.greenAccent, Colors.yellowAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: HexColor('#FFFFFF'),
                    elevation: 10,
                    child: Container(
                      height: 100,
                      width: 135,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset('assets/images/fundooIcon.jpg'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                        color: HexColor('#606E74')),
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
                            borderSide: BorderSide(color: HexColor('#658292'))),
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                            color: HexColor('#606E74')),
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
                                borderSide:
                                    BorderSide(color: HexColor('#658292'))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              borderSide: _passwordFocus.hasFocus
                                  ? const BorderSide(
                                      color: Colors.amber, width: 1.2)
                                  : BorderSide(color: HexColor('#658292')),
                            )),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () => {
                          //Navigator.pushNamed(context, '/forgot_password')
                          //forgot password screen
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const <Widget>[
                        // ignore: prefer_const_constructors
                        Text(
                          'Forgot Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, '/homescreen');
                      }),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/registrationpage');
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
