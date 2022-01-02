import 'package:flutter/material.dart';
import 'package:football/main.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:url_launcher/url_launcher.dart';

class secondPage extends StatefulWidget {
  // const secondPage({ Key? key }) : super(key: key);

  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  String _name, _email, _message;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildName() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          child: TextFormField(
            decoration: InputDecoration(
                // hintText: "Full Name ",
                labelText: "Full Name",
                labelStyle: TextStyle(fontSize: 20),
                // hintStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder()),
            // ignore: missing_return
            validator: MultiValidator([
              RequiredValidator(errorText: "Enter your name"),
              MinLengthValidator(3,
                  errorText: "name must be at least 3 characters"),
            ]),
            keyboardType: TextInputType.name,

            onSaved: (String value) {
              _name = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          child: TextFormField(
            decoration: InputDecoration(
                // hintText: "Full Name ",
                labelText: "Email address",
                labelStyle: TextStyle(fontSize: 20),
                // hintStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder()),
            // ignore: missing_return
            validator: MultiValidator([
              RequiredValidator(errorText: "Enter a valid email adress"),
              EmailValidator(errorText: "Enter a valid email address"),
            ]),
            keyboardType: TextInputType.emailAddress,
            onSaved: (String value) {
              _email = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessage() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          child: TextFormField(
            decoration: InputDecoration(
              // hintText: "Full Name ",
              labelText: "Meassage",
              labelStyle: TextStyle(fontSize: 20),

              // hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
            // ignore: missing_return
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter a message";
              }
            },
            keyboardType: TextInputType.multiline,

            onSaved: (String value) {
              _message = value;
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: FlatButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              // autovalidate: true,
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    _buildName(),
                    _buildEmail(),
                    _buildMessage(),
                    RaisedButton(
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        print(_name);
                        Utils.openEmail(
                            toEmail: "example@gmail.com",
                            subject: "mail from " + _name,
                            body: _message);
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: pColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Utils {
  static Future openLink(@required String url) => _launchUrl(url);

  static Future _launchUrl(url) async {
    await launch(url);
  }

  static Future openEmail({
    @required String toEmail,
    @required String subject,
    @required String body,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }
}
