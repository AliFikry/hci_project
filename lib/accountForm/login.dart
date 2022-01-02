import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football/accountForm/auth.dart';
import 'package:football/accountForm/forgotPassword.dart';
import 'package:football/accountForm/register.dart';
import 'package:football/accountForm/verify.dart';
import 'package:football/keys/keys.dart';
import 'package:football/main.dart';

// class WelcomePage extends StatelessWidget {
//   // const WelcomePage({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
// final AuthenticationService _auth = AuthenticationService();

// Size size = MediaQuery.of(context).size;
//     return
//   }

// }

class WelcomePage extends StatefulWidget {
  // const WelcomePage({ Key? key }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

bool saved = false;

class _WelcomePageState extends State<WelcomePage> {
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Color(0xFF191720),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.arrow_back_ios),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: size.height * .125),
              Text(
                applicationName,
                style: TextStyle(
                  fontSize: size.width * .10,
                ),
              ),
              SizedBox(height: 44),
              Text(
                "Sign In to continue",
                style: TextStyle(
                  fontSize: size.width * .05,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .6,
                ),
              ),
              SizedBox(height: 10),

              ///email
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                child: TextFormField(
                  controller: _email,
                  // obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    fillColor: Colors.red,
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              /////password
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                child: TextFormField(
                  controller: _password,
                  // obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    fillColor: Colors.red,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  signInUser();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    // width: size.width * .90,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFF282a45),
                        borderRadius: BorderRadius.circular(17)),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => forgotPassword()));
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    letterSpacing: .5,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     // await _auth.signOut();
              //     print(isLogin);
              //     print(FirebaseAuth.instance.currentUser);
              //   },
              //   child: Text("data"),
              // ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account? ",
                      style: TextStyle(fontSize: 13),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void signInUser() async {
    dynamic result =
        await _auth.loginUser(_email.text, _password.text, context);
    if (result == null) {
      // print('email invalid');
    } else {
      print(result.toString());
      // isLogin == true;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerifyPage()));
    }
  }
}
