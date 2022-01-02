import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:football/google_sign_in.dart';
import 'package:football/main.dart';
import 'package:football/settings/contactUs.dart';
import 'package:provider/provider.dart';

class MainSettingPage extends StatefulWidget {
  // const MainSettingPage({ Key? key }) : super(key: key);
  String DarkMode;
  MainSettingPage({this.DarkMode});
  @override
  _MainSettingPageState createState() => _MainSettingPageState();
}

bool _light = false;
// const keyDarkMode = 'key-dark-mode';

class _MainSettingPageState extends State<MainSettingPage> {
// final _light;

  // _MainSettingPageState(this._light);
// MainSettingPage(this._light)
  createDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xffe8e8e8),
            title: Text(
              "DELETE ACCOUNT",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("Are you sure to delete your account"),
            actions: [
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                // color: Colors.red,
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  // final provider =
                  //     Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.DeleteAccount();
                  // Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool DarkMode;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 18,
            ),
            child: SwitchListTile(
              value: _light,
              onChanged: (bool value) {
                setState(() {
                  _light = value;
                });
              },
              // leading: Icon(Icons.dark_mode, color: Color(0xFF642ef3)),
              title: Text("Dark Mode"),
              secondary: Icon(Icons.dark_mode_sharp, color: Color(0xFF642ef3)),
            ),
          ),
          Divider(
            height: 2,
          ),
          StreamBuilder<Object>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "GENERAL",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: ListTile(
                          leading: Icon(Icons.person, color: Colors.lightGreen),
                          title: Text("Account Information"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: ListTile(
                          onTap: () {},
                          title: Text("Delete account"),
                          leading: Icon(
                            FontAwesome.trash,
                            color: Color(0xFFb54b6c),
                            // size: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ListTile(
                          onTap: () {
                            // final provider = Provider.of<GoogleSignInProvider>(
                            //     context,
                            //     listen: false);
                            // provider.logOut();
                          },
                          leading: Icon(
                            FontAwesome.sign_out,
                            color: Color(0xFF749ce7),
                          ),
                          //749ce7
                          title: Text("Log out"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 2,
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "FEEDBACK",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => secondPage()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 15),
              child: Row(
                children: [
                  Icon(
                    FontAwesome.thumbs_up,
                    size: 20,
                    color: Color(0xFF7e4289),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  Text(
                    "Send Feedback",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      // color: _light ? Colors.black : Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 18, top: 20, bottom: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.ios_share,
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  Text(
                    "Share App",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
