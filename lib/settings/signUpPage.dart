import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signUpPage extends StatefulWidget {
  // const signUpPage({ Key? key }) : super(key: key);

  @override
  _signUpPageState createState() => _signUpPageState();
}

const keyDarkMode = 'key-dark-mode';

class _signUpPageState extends State<signUpPage> {
  final user = FirebaseAuth.instance.currentUser;
  bool _toggle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // signIn(),
              UserData(),
              // MainSettingPage()
            ],
          ),
        ),
      ),
    );
  }
}

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  final user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20, left: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(user.photoURL),
        ),

        // subtitle: Text("Sign out"),
        title: Text(
          user.displayName,
          style: TextStyle(
              fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
