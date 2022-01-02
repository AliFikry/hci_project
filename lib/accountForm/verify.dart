import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:football/main.dart';

class VerifyPage extends StatefulWidget {
  // const VerifyPage({ Key? key }) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

Timer timer;
// Timer sendMail;
bool isVisible = true;

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    // TODO: implement initState

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkmail();
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * .10),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFFf7f5fe),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Icon(
                      FontAwesome.envelope_open,
                      size: size.height * .08,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Check your mail",
                  style: TextStyle(
                    fontSize: size.width * .07,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .4,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  width: size.height * .40,
                  // color: Colors.green,
                  child: Text(
                    "We have sent a verification instructions to your email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: size.width * .80,
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        FirebaseAuth.instance.currentUser
                            .sendEmailVerification();
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Text(
                        "Send another mail",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue[700]),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> checkmail() async {
    await FirebaseAuth.instance.currentUser.reload();
    if (FirebaseAuth.instance.currentUser.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      FirebaseAuth.instance.currentUser.sendEmailVerification();
    }
  }

  // Future<void> sendAnotherMail() {}
}
