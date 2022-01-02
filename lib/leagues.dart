import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football/keys/keys.dart';
import 'package:football/leagues2/matchesPage.dart';
import 'package:football/test2.dart';
// import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Leagues extends StatefulWidget {
  @override
  _LeaguesState createState() => _LeaguesState();
}

var arr = [];

// String leagues = "All Teams";

class _LeaguesState extends State<Leagues> {
//  mRef;
  Query test;
  Query EgyptLeague;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    test = FirebaseDatabase.instance.reference().child("test1");
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF282a45),
          title: Text(
            "Discover",
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Icon(
                FontAwesome.search,
                size: 22,
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
        body: Container(
          child: FirebaseAnimatedList(
            query: test,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map data = snapshot.value;

              return snapshot == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Color(0xFF282a45),
                    ))
                  : data["name"] == "Israel"
                      ? SizedBox()
                      : Column(
                          children: [
                            index == 0
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 0, 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Popular League",
                                            style: TextStyle(
                                              fontSize: 20,
                                              wordSpacing: 2,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            PopularLeagues(
                                                context, 0, true, 220),
                                            PopularLeagues(
                                                context, 1, false, 110),
                                            PopularLeagues(
                                                context, 2, false, 130),
                                            PopularLeagues(
                                                context, 3, false, 73),
                                            PopularLeagues(
                                                context, 4, false, 400),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 5,
                                        color: Colors.black,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                onPressed: () {
                                  // getUserData(data["id"]);
                                  setState(() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => test2(
                                                data["id"],
                                                context,
                                                data["name"])));
                                  });
                                },
                                child: Column(
                                  children: [
                                    // Image.network(
                                    //   data["country_logo"],
                                    //   fit: BoxFit.cover,
                                    //   loadingBuilder: (BuildContext context,
                                    //       Widget child,
                                    //       ImageChunkEvent loadingProgress) {
                                    //     // ignore: unnecessary_statements
                                    //     // loadingProgress == null ?
                                    //     // return Center(
                                    //     //   child: CircularProgressIndicator(),
                                    //     // )
                                    //     return loadingProgress == null
                                    //         ? child
                                    //         : Center(
                                    //             child: CircularProgressIndicator(),
                                    //           );
                                    //   },
                                    // ),
                                    index == 0
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 25),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "All Leagues",
                                              style: TextStyle(
                                                fontSize: 19,
                                                wordSpacing: 2,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data["name"]}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Widget PopularLeagues(BuildContext context, int num, bool isSvg, double width) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => matchesLeague(context, leagueId[num]),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        width: MediaQuery.of(context).size.width * .31,
        // height: MediaQuery.of(context).size.height * .15,
        height: 115,
        decoration: BoxDecoration(
          color: Color(leaguesColor[num]),
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        //color: Colors.amber,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            isSvg == true
                ? Center(
                    child: SvgPicture.network(
                      '${leagueFlag[num]}',
                      width: width,
                      height: 93,
                      // color: Colors.green,
                    ),
                  )
                : Center(
                    child: Image.network(
                      '${leagueFlag[num]}',
                      width: width,
                      height: 90,
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}
