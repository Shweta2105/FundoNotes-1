import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/basescreen.dart';
import 'package:hexcolor/hexcolor.dart';

class RegistrationPage extends BaseScreen {
  @override
  RegistrationPageState createState() => new RegistrationPageState();
}

class RegistrationPageState extends BaseScreenState {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  FocusNode fnameFocus = new FocusNode();
  FocusNode lnameFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool fnameValid = true;
  bool lnameValid = true;
  bool emailValid = true;
  bool passwordValid = true;
  bool matchPassword = true;
  RegExp emailRegExp = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordRegExp =
      new RegExp(r"^(?=.*?[0-9a-zA-Z])[0-9a-zA-Z]*[@#$%!][0-9a-zA-Z]*$");

  void initState() {
    fnameController = TextEditingController();
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
                          const CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max')),
                          Positioned(
                              bottom: -10,
                              left: 70,
                              child: IconButton(
                                  onPressed: () {},
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
                            value.length <= 15
                                ? fnameValid = true
                                : fnameValid = false;
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
                            value.length <= 15
                                ? lnameValid = true
                                : lnameValid = false;
                            setState(() {});
                          },
                          style: new TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: HexColor('#606E74')),
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
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text(
                              'SignUp',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () {},
                          )),
                      Container(
                          child: Row(
                        children: <Widget>[
                          FlatButton(
                            textColor: Colors.blue,
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
