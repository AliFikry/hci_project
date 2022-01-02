import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

// import 'google_sign_in.dart';

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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Divider(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  onTap: () {
                    // final provider = Provider.of<GoogleSignInProvider>(context,
                    //     listen: false);
                    // provider.googleLogin();
                    // print(FirebaseAuth.instance.currentUser);
                  },
                  title: Text(
                    "Sign up with Google",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  leading: Image.asset(
                    'images/google-logo-9808.png',
                    width: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ListTile(
                  tileColor: Color(0xff4167b2),
                  dense: true,
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
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Dismiss"))
            ],
          ),
        );
      });
}
