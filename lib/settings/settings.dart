// import 'dart:html';

// import 'dart:html';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:football/settings/contactUs.dart';
// import 'package:football/google_sign_in.dart';
import 'package:football/main.dart';
// import 'package:football/var.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:football/main.dart';
import 'package:football/settings/newUser.dart';
import 'package:football/settings/contactUs.dart';
import 'package:football/side%20pages/accountInfomation.dart';
// import 'package:football/settingPage.dart';
import 'package:football/settings/signUpPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'dataAndButton.txt';

class Settings extends StatefulWidget {
  String DarkMode;
  Settings({this.DarkMode});
  @override
  _SettingsState createState() => _SettingsState(DarkMode);
}

String test(args) {
  // print("tect");
  return 'test';
}

// bool _toggle = true;

// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _SettingsState extends State<Settings> {
  _SettingsState(String darkMode);

  // @override
  // void initState() {
  //   super.initState();
  //   // FirebaseAuth.instance.onAuthStateChanged.listen
  // }

  bool _light = false;
  final emailController = TextEditingController();
  String password = '';
  bool isVisible = false;
  bool widgetVisible = true;
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    // _SettingsState(this.DarkMode);
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      color: Color(0xFF282a45),
      home: Scaffold(
        // resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: Color(0xFF282a45),
          elevation: 0,
          centerTitle: true,
          title: Text("Settings"),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 22,
            ),
          ),
        ),
        // backgroundColor: DarkMode == false ? Colors.amber : Colors.blue,
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF282a45),
          child: ListView(
            padding: EdgeInsets.all(22),
            children: [
              Container(
                child: _isLoggedIn == true
                    ? Container(
                        width: MediaQuery.of(context).size.width * .90,
                        // padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFF393c52),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: ListTile(
                                    // dense: true,
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 5),
                                      child: Text(
                                        _userObj.displayName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    leading: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      child: Image.network(_userObj.photoUrl),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.white,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      _googleSignIn
                                          .signOut()
                                          .then((value) => {
                                                setState(
                                                    () => {_isLoggedIn = false})
                                              })
                                          .catchError((e) => {print(e)});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(13),
                                      child: Text(
                                        "Sign out",
                                        style: TextStyle(
                                            color: Colors.red[700],
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          child: ListTile(
                            // style: c,
                            // selectedColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            dense: true,
                            onTap: () {
                              _googleSignIn
                                  .signIn()
                                  .then((userData) => {
                                        setState(() => {
                                              _isLoggedIn = true,
                                              _userObj = userData
                                            })
                                      })
                                  .catchError((e) => {print(e)});

                              // print("working");
                              // print(FirebaseAuth.instance.currentUser.displayName);
                            },
                            title: Text(
                              "Sign up with Google",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            // tileColor: Color(0xfffdfdfd),
                            // dense: true,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(20),
                            //   ),
                            // ),
                            leading: Image.asset(
                              'images/google-logo-9808.png',
                              width: 25,
                            ),
                          ),
                        ),
                      ),
              ),
              nightMode(context),
              general(context, _isLoggedIn, _userObj),
              // general(context),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              // )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Widget nightMode(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 20, bottom: 20),
    child: Container(
      width: MediaQuery.of(context).size.width * .90,
      // height: 200,
      decoration: BoxDecoration(
        color: Color(0xFF393c52),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            // alignment: Alignment.centerLeft,
            child: Text(
              "interface",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "night mode",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "Get that whitness out of my sight",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          )
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names

Widget general(
    BuildContext context, bool isloggedIn, GoogleSignInAccount _userObj) {
  return Container(
    // padding: EdgeInsets.only(bottom: 20),
    width: MediaQuery.of(context).size.width * .90,
    // height: 200,
    decoration: BoxDecoration(
      color: Color(0xFF393c52),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "General",
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
        isloggedIn == true
            ? ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AccountInformation(context, _userObj),
                    ),
                  );
                },
                dense: true,
                title: Text(
                  "Account Infomation",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "Name, Email Address, Password",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  color: Colors.white,
                ),
              )
            : SizedBox(),
        ListTile(
          dense: true,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => secondPage()));
          },
          title: Text(
            "Send us feedback",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "Contact us by email",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 22,
            color: Colors.white,
          ),
        ),
        ListTile(
          dense: true,
          title: Text(
            "Share app",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "Share application with friend",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 22,
            color: Colors.white,
          ),
        ),
        ListTile(
          dense: true,
          onTap: () {
            launch(
                "https://www.termsandconditionsgenerator.com/live.php?token=4hd7f9R2FGuzvYTsmuRZoRQbnHvCvYeS");
          },
          title: Text(
            "Term and conditions",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "see our term and condition",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 22,
            color: Colors.white,
          ),
        ),
        ListTile(
          dense: true,
          title: Text(
            "Rate us on the store",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            "you can help us by rating us on the store",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 22,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
