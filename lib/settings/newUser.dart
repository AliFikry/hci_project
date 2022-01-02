// import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:football/google_sign_in.dart';
import 'package:football/main.dart';

// import 'package:football/settingPage.dart';
import 'package:provider/provider.dart';

class DarkTheme extends StatefulWidget {
  // const DarkTheme({ Key? key }) : super(key: key);

  @override
  _DarkThemeState createState() => _DarkThemeState();
}

const keyDarkMode = 'key-dark-mode';

class _DarkThemeState extends State<DarkTheme> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

ThemeData _darkMode = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.pink,
  primaryColor: Colors.blue,
);
ThemeData _lightMode = ThemeData(
  brightness: Brightness.light,
  accentColor: Colors.red,
  primaryColor: Colors.amber,
);

bool _light = true;

class newUser extends StatefulWidget {
  // const SignInButton({ Key? key }) : super(key: key);

  @override
  _newUserState createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  final user = FirebaseAuth.instance.currentUser;
  bool _toggle = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              signButton()
              // MainSettingPage()
            ],
          ),
        ),
      ),
    );
  }
}

class signButton extends StatefulWidget {
  // const signButton({ Key? key }) : super(key: key);

  @override
  _signButtonState createState() => _signButtonState();
}

class _signButtonState extends State<signButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ListTile(
        tileColor: pColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        leading: Icon(
          FontAwesome.user_circle_o,
          color: Colors.white,
        ),
        dense: true,
        title: Text(
          "Sign in",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onTap: () async {
          var result = await Connectivity().checkConnectivity();
          // print(ConnectivityResult.values[2]);
          switch (result) {
            case ConnectivityResult.wifi:
              _modalPress(context);

              break;
            case ConnectivityResult.mobile:
              _modalPress(context);

              break;
            case ConnectivityResult.none:
              createDialog(context);
              break;
          }
        },
      ),
    );
  }
}

createDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffe8e8e8),
          title: Icon(MaterialCommunityIcons.wifi_off),
          content: Text(
              "It looks like we have a problem. Please check your connection and try again"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(child: Text("Dismiss")),
            )
          ],
        );
      });
}

_modalError(context) {
  showModalBottomSheet(
      backgroundColor: Color(0xffe8e8e8),
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          // bottomLeft: Radius.circular(20),
          // bottomRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .10,
          child: Center(
            child: Text(
              "Check your internet",
              style: TextStyle(color: Color(0xFFf4192e), fontSize: 20),
            ),
          ),
        );
      });
}

_modalPress(context) {
  showModalBottomSheet(
      backgroundColor: Color(0xffe8e8e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .30,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Divider(
                height: 2,
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                child: ListTile(
                  dense: true,
                  onTap: () {
                    // final provider = Provider.of<GoogleSignInProvider>(context,
                    //     listen: false);
                    // provider.googleLogin();
                    // print("working");
                    Navigator.of(context).pop();
                  },
                  leading: Image.asset(
                    'images/google-logo-9808.png',
                    width: 25,
                  ),
                  title: Text(
                    "Sign up with Google",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  tileColor: Color(0xfffdfdfd),
                  // dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  // leading: Image.asset(
                  //   'images/google-logo-9808.png',
                  //   width: 25,
                  // ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                child: ListTile(
                  tileColor: Color(0xff4167b2),
                  dense: true,
                  onTap: () async {
                    // final facebookLogin = FacebookLogin();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  leading: Icon(
                    FontAwesome.facebook,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Sign up with facebook",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
