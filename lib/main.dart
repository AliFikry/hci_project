import 'dart:async';
// import 'dart:js';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/accountForm/login.dart';
import 'package:football/leagues.dart';
import 'package:football/matches.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:football/news/news.dart';

// import 'package:football/settingPage.dart';
import 'package:football/theme.dart';
import 'package:football/highlight/highlights.dart';

// import 'package:connectivity/connectivity.dart';

// import 'google_sign_in.dart';

String DarkMode = "false";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(builder: (context) => MyApp()));
}

Color pColor = Color.fromRGBO(35, 128, 252, 1.0);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

bool isLogin = false;

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names, unused_field
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: currentTheme.currentTheme,
        home: isLogin == true ? MyHomePage() : WelcomePage(),
        debugShowCheckedModeBanner: false,
      );
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _Page = [
    Matches(),
    Leagues(),
    News(),
    highlights(),
    // Settings(DarkMode: DarkMode)
  ];
  int _selectedPageIndex = 0;

  void _x1(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        body: _Page[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            iconSize: 26,
            elevation: 0,
            selectedItemColor: Color(0xFF282a45),
            unselectedItemColor:
                Color.fromRGBO(172, 167, 167, 0.8549019607843137),
            currentIndex: _selectedPageIndex,
            onTap: _x1,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    MaterialCommunityIcons.soccer_field,
                  ),
                  label: "Matches"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesome.trophy), label: "Leagues"),
              BottomNavigationBarItem(
                  icon: Icon(MaterialCommunityIcons.trending_up),
                  label: "News"),
              BottomNavigationBarItem(
                  icon: Icon(
                    MaterialCommunityIcons.lightbulb_on,
                    // color: Colors.yellow,
                  ),
                  // ignore: deprecated_member_use
                  label: "Highlight"),
            ]),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
