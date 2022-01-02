import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/keys/keys.dart';
import 'package:football/leagues2/matchesPage.dart';
import 'package:http/http.dart' as http;

// import 'package:football/leagues.dart';
var array = [];
var arrayLogo = [];
var arrayId = [];
var countryName;
Widget test2(String i, BuildContext context, String name) {
  Future getUserData() async {
    void empty_array() {
      array = [];
      arrayLogo = [];
      arrayId = [];
    }

    var response = await http.get(
      Uri.http('apiv3.apifootball.com',
          '/?action=get_leagues&country_id=${i}&APIkey=$apiKey'),
    );
    var jsonData = jsonDecode(response.body);

    // var jsonData = jsonDecode(response);
    // print(jsonData);
    countryName = name;
    empty_array();

    for (var i = 0; i < jsonData.length; i++) {
      array.add(jsonData[i]["league_name"]);
      arrayLogo.add(jsonData[i]["league_logo"]);
      arrayId.add(jsonData[i]["league_id"]);
    }
    for (var i = 0; i < arrayLogo.length; i++) {
      if (arrayLogo[i] == "") {
        arrayLogo[i] =
            "https://pngimg.com/uploads/football/football_PNG52789.png";
      }
    }
  }

  // empty_array();

  getUserData().then(
    (value) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Test()),
    ),
  );
  return Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF282a45),
          elevation: 1,
          centerTitle: true,
          title: Text(
            countryName,
            style: TextStyle(fontSize: 25),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // array=[];
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        body: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            array = [];
          },
          child: Container(
            // color: Color(0xFF282a45),
            child: ListView.builder(
                itemCount: array.length,
                itemBuilder: (__, index) {
                  // print(arrayLogo[4].toString());

                  return FlatButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              matchesLeague(context, arrayId[index]),
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.network(arrayLogo[index],
                                // ignore: unrelated_type_equality_checks
                                width: arrayLogo[index]
                                            .toString()
                                            .indexOf("pngimg") ==
                                        8
                                    ? 22
                                    : 27),
                          ),
                          Text("${array[index]}", textAlign: TextAlign.left)
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
