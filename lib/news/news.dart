import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football/main.dart';
// import 'package:football/trendSection.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Query _ref, _ref2;
  // Query _refTrends;
  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child("Football News");
    _ref2 = FirebaseDatabase.instance.reference().child("Football Transfer");

    // _refTrends = FirebaseDatabase.instance.reference().child("Football Trends");
  }

  Widget _buildNews({Map news}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                news["urlImage"],
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * .20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  news["title"],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      news["source"],
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF909090),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    child: Row(
                      children: [
                        Text(
                          "Read More ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.5),
                          child: Icon(
                            FontAwesome.chevron_right,
                            size: 6.5,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      launch(news["url"]);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransfer({Map transfer}) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        '${transfer["urlImage"]}',
                        width: MediaQuery.of(context).size.width * .34,
                        // height: MediaQuery.of(context).size.width * .23,
                        // height: MediaQuery.of(context).size.width * .25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .54,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(transfer["title"],
                              style: TextStyle(fontSize: 12)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            transfer["source"],
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          InkWell(
                            child: Row(
                              children: [
                                Text(
                                  "Read More ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.5),
                                  child: Icon(
                                    FontAwesome.chevron_right,
                                    size: 6.5,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              launch(transfer["url"]);
                            },
                          )
                          // TextButton(onPressed: () {}, child: Text("data"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("News"),
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(
                text: "News",
              ),
              Tab(
                text: "Transfer",
              )
            ]),
          ),
          body: TabBarView(children: [
            StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                // ignore: missing_return
                // snapshot != null &&
                //       snapshot.hasData &&
                builder: (BuildContext context,
                    AsyncSnapshot<ConnectivityResult> snapshot) {
                  if (snapshot.data != ConnectivityResult.none) {
                    return FirebaseAnimatedList(
                      query: _ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map news = snapshot.value;
                        return _buildNews(news: news);
                      },
                    );
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * .24, 0, 0, 0),
                        child: ListTile(
                          leading: Icon(
                            Icons.wifi_off,
                            size: 30,
                          ),
                          title: Text("not connected"),
                        ),
                      ),
                    );
                  }
                }),
            StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                // ignore: missing_return
                // snapshot != null &&
                //       snapshot.hasData &&
                builder: (BuildContext context,
                    AsyncSnapshot<ConnectivityResult> snapshot) {
                  if (snapshot.data != ConnectivityResult.none) {
                    return FirebaseAnimatedList(
                      query: _ref2,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map transfer = snapshot.value;
                        return _buildTransfer(transfer: transfer);
                      },
                    );
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * .24, 0, 0, 0),
                        child: ListTile(
                          leading: Icon(
                            Icons.wifi_off,
                            size: 30,
                          ),
                          title: Text("not connected"),
                        ),
                      ),
                    );
                  }
                }),
          ]),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


