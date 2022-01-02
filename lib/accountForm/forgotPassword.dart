import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class forgotPassword extends StatefulWidget {
  // const forgotPassword({ Key? key }) : super(key: key);

  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

TextEditingController _email = TextEditingController();

class _forgotPasswordState extends State<forgotPassword> {
  final formKey = GlobalKey<FormState>();
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
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Reset password",
                style: TextStyle(
                  fontSize: size.width * .07,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Enter the email linked with your account and we'll send an email with instructions to reset your password",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                // autovalidatem: true,
                child: TextFormField(
                  controller: _email,
                  // obscureText: true,
                  style: TextStyle(color: Colors.black),
                  // ignore: missing_return
                  validator: MultiValidator([
                    EmailValidator(errorText: "Invalid email"),
                    RequiredValidator(errorText: "Enter email")
                  ]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    // fillColor: Colors.red,
                    labelText: "Email address",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
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
              SizedBox(height: 12),
              InkWell(
                onTap: () {
                  if (formKey.currentState.validate()) {
                    // FirebaseAuth.instance
                    //     .fetchSignInMethodsForEmail(_email.text);
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _email.text)
                        .catchError((e) => print("object"));
                  } else {}
                },
                child: Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Reset",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        letterSpacing: .6),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
