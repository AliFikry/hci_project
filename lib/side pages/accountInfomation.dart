import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget AccountInformation(BuildContext context, GoogleSignInAccount _userObj) {
  return MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF282a45),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: Text("Profile"),
        ),
        body: Container(
          color: Color(0xFF282a45),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    child: Image.network(
                      _userObj.photoUrl,
                      scale: 0.7,
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Container(
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
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              "ID",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          title: Text(
                            _userObj.id,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Divider(
                          height: 0.1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Icon(
                              MaterialCommunityIcons.account,
                              size: 27,
                            ),
                          ),
                          title: Text(
                            _userObj.displayName,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Divider(
                          height: 0.1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Icon(
                              MaterialCommunityIcons.at,
                              size: 27,
                            ),
                          ),
                          title: Text(
                            _userObj.email,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
    debugShowCheckedModeBanner: false,
  );
}
