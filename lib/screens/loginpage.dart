import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
//import 'package:fundonotes/api/networkmanager.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:fundonotes/models/common/customsnackbar.dart';
import 'package:fundonotes/resources/authmethod.dart';
import 'package:fundonotes/screens/homescreen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fundonotes/models/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends BaseScreen {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseScreenState {
  late SharedPreferences loginData;
  late bool newuser;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool emailValid = true;
  bool passwordValid = true;

  Future<void> getData() async {
    loginData = await SharedPreferences.getInstance();
    newuser = (loginData.getBool('login') ?? true);

    if (newuser == false) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext build) => const HomeScreen()));
    }
  }

  loginUser() async {
    String result = await AuthMethod.loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (result == 'success') {
      loginData.setBool('login', false);
      loginData.setString('emailId', _emailController.text);
      Navigator.pushNamed(context, '/homescreen');
      //snackbar
      CustomSnackbar.show(context, "Login Successfull...!");
    } else {
      //snackbar
      CustomSnackbar.show(context, "Login Failed... Check Id and password");
    }
    return result;
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 10.0,
        title: Text('FundoNotes Login',
            style: TextStyle(
              color: titlecolor,
              fontWeight: FontWeight.w400,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            )),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.greenAccent, Colors.yellowAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: whitebackcolor,
                    elevation: 10,
                    child: SizedBox(
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                    style: TextStyle(
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: textcolor),
                      decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: passwordValid ? null : "Invalid password",
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
                            color: buttoncolorblue,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      textColor: buttoncolorwhite,
                      color: buttoncolorblue,
                      child: const Text('Login',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      onPressed: loginUser),
                ),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    FlatButton(
                      textColor: buttoncolorblue,
                      child: const Text(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
