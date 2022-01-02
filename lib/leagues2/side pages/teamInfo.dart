// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football/keys/keys.dart';
import 'package:football/leagues2/side%20pages/playerInfo.dart';

// import 'package:football/leagues2/matchesPage.dart';
// import 'package:football/leagues2/matchesPage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// import 'package:transparent_image/transparent_image.dart';
// import 'package:invoiceninja/invoiceninja.dart';
// import 'package:transparent_image/transparent_image.dart';

var teamName, teamBadge;
var goalKeeper = [], defender = [], midFielders = [], forward = [];
var goalkeeperImage = [];
var goalKeeperNumber = [],
    defenderNumber = [],
    midFieldersNumber = [],
    forwardNumber = [];
var goalKeeperId = [], defenderId = [], midFieldId = [], forwardId = [];
dynamic h2h;

void empty() {
  goalKeeper = [];
  defender = [];
  midFielders = [];
  forward = [];

  ///////////////////////////

  goalKeeperNumber = [];
  defenderNumber = [];
  midFieldersNumber = [];
  forwardNumber = [];

  ///////////////////////////

  goalKeeperId = [];
  defenderId = [];
  midFieldId = [];
  forwardId = [];
}

Widget teamInfo(BuildContext context, String teamId, String league_name,
    String league_logo) {
  Future getData() async {
    var event_to = DateFormat.y().format(
          DateTime.now().subtract(
            Duration(days: 30),
          ),
        ) +
        "-" +
        DateFormat.M().format(
          DateTime.now().subtract(
            Duration(days: 30),
          ),
        ) +
        "-" +
        DateFormat.d().format(
          DateTime.now().subtract(
            Duration(days: 30),
          ),
        );
    var event_from = DateFormat.y().format(DateTime.now()) +
        "-" +
        DateFormat.M().format(DateTime.now()) +
        "-" +
        DateFormat.d().format(DateTime.now());
    empty();
    var respone = await http.get(Uri.http("apiv3.apifootball.com",
        "/?action=get_teams&team_id=${teamId}&APIkey=${apiKey}"));
    var info = jsonDecode(respone.body);
    for (var i = 0; i < info[0]["players"].length; i++) {
      // print(info[0]["players"][i]["player_type"]);
      if (info[0]["players"][i]["player_type"] == "Goalkeepers") {
        goalKeeper.add(info[0]["players"][i]["player_name"]);
        goalKeeperNumber.add(info[0]["players"][i]["player_number"]);
        goalKeeperId.add(info[0]["players"][i]["player_id"]);
      } else if (info[0]["players"][i]["player_type"] == "Defenders") {
        defender.add(info[0]["players"][i]["player_name"]);
        defenderNumber.add(info[0]["players"][i]["player_number"]);
        defenderId.add(info[0]["players"][i]["player_id"]);
      } else if (info[0]["players"][i]["player_type"] == "Midfielders") {
        midFielders.add(info[0]["players"][i]["player_name"]);
        midFieldersNumber.add(info[0]["players"][i]["player_number"]);
        midFieldId.add(info[0]["players"][i]["player_id"]);
      } else if (info[0]["players"][i]["player_type"] == "Forwards") {
        forward.add(info[0]["players"][i]["player_name"]);
        forwardNumber.add(info[0]["players"][i]["player_number"]);
        forwardId.add(info[0]["players"][i]["player_id"]);
      } else {}
    }
    // for (var i in goalKeeper) {
    //   print(i);
    // }
    // print(info[0]["players"].length);
    var event = await http.get(Uri.http("apiv3.apifootball.com",
        "/?action=get_events&from=$event_to&to=$event_from&team_id=$teamId&APIkey=$apiKey"));
    // print(teamId);
    // print(event_from);
    // print(event_to);
    // print(apiKey);
    var eventResponse = jsonDecode(event.body);
    h2h = eventResponse;
    // print(eventResponse[0]);
    // print(eventResponse[1]);
    teamName = info[0]["team_name"];
    teamBadge = info[0]["team_badge"];
  }

  getData().then((value) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TeamInfo(
            league_name: league_name,
            league_logo: league_logo,
          ),
        ),
      ));
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        color: Color(0xFF282a45),
      ),
    ),
  );
}

class TeamInfo extends StatefulWidget {
  // final String teamId;
  final String league_name;
  final String league_logo;

  const TeamInfo({this.league_name, this.league_logo}) : super();

  @override
  _TeamInfoState createState() => _TeamInfoState();
}

class _TeamInfoState extends State<TeamInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xFF282a45),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(20),
            //     bottomRight: Radius.circular(20),
            //   ),
            // ),
            // title: Text(widget.league_name.toString()),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 25,
              ),
            ),
            bottom: PreferredSize(
              child: Column(
                children: [
                  Image.network(
                    "$teamBadge",
                    // width: MediaQuery.of(context).size.height
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Text(
                    teamName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  TabBar(
                    // isScrollable: true,
                    indicatorColor: Colors.white,
                    // indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: "Overview",
                      ),
                      Tab(
                        text: "Squad",
                      )
                    ],
                  )
                ],
              ),
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * .30),
            ),
          ),
          body: TabBarView(children: [
            overView(context, widget.league_logo, widget.league_name),
            squad(context)
          ]),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Widget overView(BuildContext context, String logo, String name) {
  // print(logo);
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        "$logo",
                        width: 70,
                        height: 35,
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          color: Color(0xFFe5e5e5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                child: Text(
                  "Matches",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.black,
              ),
              Container(
                // color: Color(0xFFe5e5e5),
                height: MediaQuery.of(context).size.height * .19,
                child: ListView.builder(
                  itemCount: h2h.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (__, index) {
                    // var color; //green = 1   red = 0

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(h2h[index]["match_date"]
                                .toString()
                                .substring(5)),
                            SizedBox(height: 7),
                            Image.network(
                              teamName == h2h[index]["match_hometeam_name"]
                                  ? h2h[index]["team_away_badge"]
                                  : h2h[index]["team_home_badge"],
                              width: 60,
                              height: MediaQuery.of(context).size.height * .06,
                            ),
                            SizedBox(height: 7),
                            Text(
                              "${h2h[index]["match_hometeam_ft_score"] + " - " + h2h[index]["match_awayteam_ft_score"]}",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 7),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                // color: teamName ==
                                //         h2h[index]["match_hometeam_name"]
                                //     ? h2h[index]["match_awayteam_ft_score"] >
                                //             h2h[index]
                                //                 ["match_hometeam_ft_score"]
                                //         ? Colors.green
                                //         : Colors.red
                                //     : Colors.red,

                                color: teamName ==
                                        h2h[index]["match_hometeam_name"]
                                    || int.parse("${h2h[index]["match_awayteam_ft_score"]}") >
                                        int.parse( h2h[index]["match_hometeam_ft_score"])
                                        ? Colors.green:int.parse("${h2h[index]["match_awayteam_ft_score"]}") ==
                                    int.parse( h2h[index]["match_hometeam_ft_score"])?Colors.yellow
                                        : Colors.red
                                   ,
                                borderRadius: BorderRadius.circular(180),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget squad(BuildContext context) {
  return ListView(
    children: [
      squadTable(
          context, "GoalKeeper", goalKeeper, goalKeeperNumber, goalKeeperId),
      squadTable(context, "Defenders", defender, defenderNumber, defenderId),
      squadTable(
          context, "Midfielders", midFielders, midFieldersNumber, midFieldId),
      squadTable(context, "Strickers", forward, forwardNumber, forwardId),
    ],
  );
}

Widget squadTable(BuildContext context, String title, List<dynamic> arr,
    List<dynamic> arrNumber, List<dynamic> arrId) {
  return Column(
    children: [
      Container(
        color: Color(0xFFe5e5e5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 6, 10, 0),
              child: Text(
                "${title}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: arr.length,
                itemBuilder: (__, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 0.5, color: Colors.black),
                      // SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => playerInfo(
                                context,
                                arrId[index],
                                teamBadge,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image.network(
                              //   "${goalKeeperImage[index]}",
                              //   width: 20,
                              //   errorBuilder: (context, error, stackTrace) {
                              //     print(error);
                              //     return Text("data");
                              //   },
                              // ),

                              Text(
                                "${arr[index].toString() + "      " + arrId[index].toString()}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        arrNumber[index].toString().length == 1
                                            ? 6
                                            : 0),
                                child: Text(
                                  arrNumber[index].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
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
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Color(0xFF282a45),
          width: MediaQuery.of(context).size.width,
          height: 1.2,
        ),
      )
    ],
  );
}
