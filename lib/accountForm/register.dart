import 'package:flutter/material.dart';
import 'package:football/accountForm/auth.dart';
import 'package:football/accountForm/login.dart';
import 'package:football/accountForm/verify.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  // const register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String password;
  bool _value = false;
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
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: size.height * .10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                // width: size.width * .50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                      text: "Create ",
                      style: TextStyle(
                        fontSize: size.width * .10,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                    Text.rich(TextSpan(
                      text: "Account",
                      style: TextStyle(
                        fontSize: size.width * .10,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 30),

              ///email
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 9),
                      child: TextFormField(
                        controller: _email,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Enter email"),
                          EmailValidator(errorText: "Invalid email"),
                        ]),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(18),
                          fillColor: Colors.red,
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
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
                          border: OutlineInputBorder(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 9),
                      child: TextFormField(
                        obscureText: true,
                        controller: _password,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'password is required'),
                          MinLengthValidator(8,
                              errorText:
                                  'password must be at least 8 digits long'),
                        ]),
                        onChanged: (val) => password = val,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(18),
                          fillColor: Colors.red,
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
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
                          border: OutlineInputBorder(
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
                    //paswword repeat
                  ],
                ),
              ),

              CheckboxListTile(
                  title: Text.rich(
                    TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                              text: " and ",
                              style: TextStyle(
                                fontSize: 13,
                              )),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 13,
                                decoration: TextDecoration.underline),
                          )
                        ]),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      // print(_value);
                      _value = value;
                    });
                  }),
              SizedBox(height: 10),

              InkWell(
                onTap: () {
                  if (formKey.currentState.validate() && _value == true) {
                    print("object");
                    createNewUser();
                  } else {}
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      "Create account",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 13),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => WelcomePage(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          color: Colors.blue[400],
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

  void createNewUser() async {
    dynamic result =
        await _auth.createNewUser(_email.text, _password.text, context);
    if (result == null) {
    } else {
      print(result.toString());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomePage()));
    }
  }
}
