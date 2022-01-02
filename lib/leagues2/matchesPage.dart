// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:convert';
import 'package:football/keys/keys.dart';
import 'package:football/leagues2/teamsTables.dart';
import 'package:football/leagues2/playedMatches.dart';
import 'package:football/leagues2/upcomingMatches.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// match_date
var isData = "true";
var homeTeam = [];
var awayTeam = [];
var matchesDate = [];
var homeTeamScore = [];
var awayTeamScore = [];
var matchId = [];
var teamlogos = [];
// ------------------- //
var teamsOrder = [];
var overall_wins = [];
var overall_draws = [];
var overall_loses = [];
var matchesPlayed = [];
var points = [];
var teamId = [];

// ------------------- //
var upcomingHomeTeam = [];
var upcomingAwayTeam = [];
var upcomingDate = [];
var upcomingTime = [];
var upcomingMatchId = [];

String league_name, league_logo;
var todayDate;
var fromDate;

void empty_array() {
  homeTeam = [];
  awayTeam = [];
  matchesDate = [];
  homeTeamScore = [];
  awayTeamScore = [];
  matchId = [];
  teamlogos = [];

  teamsOrder = [];
  overall_wins = [];
  overall_draws = [];
  overall_loses = [];
  matchesPlayed = [];
  points = [];
  teamId = [];

  upcomingHomeTeam = [];
  upcomingAwayTeam = [];
  upcomingDate = [];
  upcomingTime = [];
  upcomingMatchId = [];
}

Widget matchesLeague(BuildContext context, String i) {
  Future getUserData() async {
    var days = DateFormat.d().format(DateTime.now().subtract(
      Duration(days: 30),
    ));
    var month = DateFormat.M().format(DateTime.now().subtract(
      Duration(days: 30),
    ));
    days.length == 1 ? days = "0" + days : days = days;
    month.length == 1 ? month = "0" + month : month = month;
    fromDate = DateFormat.y().format(DateTime.now().subtract(
          Duration(days: 30),
        )) +
        "-" +
        month +
        "-" +
        days;
    todayDate =
        DateFormat.y().format(DateTime.now().subtract(Duration(days: 1))) +
            "-" +
            DateFormat.M().format(DateTime.now()) +
            "-" +
            DateFormat.d().format(DateTime.now());

    var toDateUpcoming = DateFormat.y().format(DateTime.now().add(
          Duration(days: 30),
        )) +
        "-" +
        DateFormat.M().format(DateTime.now().add(
          Duration(days: 30),
        )) +
        "-" +
        DateFormat.d().format(DateTime.now().add(
          Duration(days: 30),
        ));
    var fromDateUpcoming = DateFormat.y().format(
          DateTime.now().add(
            Duration(days: 1),
          ),
        ) +
        "-" +
        DateFormat.M().format(
          DateTime.now().add(
            Duration(days: 1),
          ),
        ) +
        "-" +
        DateFormat.d().format(
          DateTime.now().add(
            Duration(days: 1),
          ),
        );

    var response = await http.get(
      Uri.http('apiv3.apifootball.com',
          '/?action=get_events&from=${fromDate}&to=${todayDate}&league_id=${i}&APIkey=$apiKey'),
    );
    var upcomingMatches = await http.get(
      Uri.http('apiv3.apifootball.com',
          '/?action=get_events&from=${fromDateUpcoming}&to=${toDateUpcoming}&league_id=${i}&APIkey=${apiKey}'),
    );
    var teamsTables = await http.get(
      Uri.http('apiv3.apifootball.com',
          '/?action=get_standings&league_id=${i}&APIkey=${apiKey}'),
    );
    var table = jsonDecode(teamsTables.body);
    var jsonData = jsonDecode(response.body);
    var upcoming = jsonDecode(upcomingMatches.body);
    league_name = jsonData[0]["league_name"];
    league_logo = jsonData[0]["league_logo"];

    print(jsonData);
    empty_array();

    for (var j = 0; j < table.length; j++) {
      teamsOrder.add(table[j]["team_name"]);
      overall_wins.add(table[j]["overall_league_W"]);
      overall_draws.add(table[j]["overall_league_D"]);
      overall_loses.add(table[j]["overall_league_L"]);
      matchesPlayed.add(table[j]["overall_league_payed"]);
      points.add(table[j]["overall_league_PTS"]);
      teamId.add(table[j]["team_id"]);
      teamlogos.add(table[j]["team_badge"]);
    }
    for (var i = 0; i < jsonData.length; i++) {
      homeTeam.add(jsonData[i]["match_hometeam_name"]);
      awayTeam.add(jsonData[i]["match_awayteam_name"]);
      matchesDate.add(jsonData[i]["match_date"]);
      homeTeamScore.add(jsonData[i]["match_hometeam_ft_score"]);
      awayTeamScore.add(jsonData[i]["match_awayteam_ft_score"]);
      matchId.add(jsonData[i]["match_id"]);
    }
    for (var k = 0; k < upcoming.length; k++) {
      upcomingHomeTeam.add(upcoming[k]["match_hometeam_name"]);
      upcomingAwayTeam.add(upcoming[k]["match_awayteam_name"]);
      upcomingDate.add(upcoming[k]["match_date"]);
      upcomingTime.add(upcoming[k]["match_time"]);
      upcomingMatchId.add(upcoming[k]["match_id"]);
    }
  }

  getUserData().then((value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Standing_matches(context, league_name, i),
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

Container Standing_matches(BuildContext context, String name, String i) {
  bool isFavorite = false;
  return Container(
    child: Center(
      child: MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              // backgroundColor: Color(bgColor),
              backgroundColor: Color(0xFF282a45),
              title: Text(
                name.toString(),
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    onPressed: () {
                      isFavorite = !isFavorite;
                      print(isFavorite);
                    },
                    icon: Icon(
                      isFavorite == true ? Icons.star_rate : Icons.star_border,
                    ),
                    color: Colors.white,
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Table",
                    ),
                    Tab(
                      text: "Played",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                  ],
                ),
              ),
            ),
            // body: upcomingMatches(),
            body: TabBarView(children: [
              table(context, league_name, league_logo),
              playedMatches(context),
              upcomingMatches()
              // Container(
              //   child: Text("data"),
              // )
            ]),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}


// WillPopScope upcomingMatches() {
//   return WillPopScope(
//     // ignore: missing_return
//     onWillPop: () {
//       empty_array();
//     },
//     child: Container(
//       // color: Color(0xFF282a45),
//       child: isData == "false"
//           ? Container(
//               child: Center(
//                 child: Text(
//                   "no matches",
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//             )
//           : ListView.builder(
//               itemCount: homeTeam.length,
//               itemBuilder: (__, index) {
//                 int reversedIndex = homeTeam.length - 1 - index;

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 15,
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 15,
//                           color: Colors.grey,
//                           offset: const Offset(1, 1),
//                         )
//                       ],
//                     ),
//                     padding: EdgeInsets.all(15),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             child: Text(
//                               homeTeam[reversedIndex].toString(),
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                             child: Column(
//                           children: [
//                             Container(
//                               child: Text(
//                                 matchesDate[reversedIndex]
//                                     .toString()
//                                     .substring(5),
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 50,
//                               child: Divider(height: 2, color: Colors.grey),
//                             ),
//                             Container(
//                               child: Text(
//                                 homeTeamScore[reversedIndex] == ""
//                                     ? "up coming"
//                                     : "${homeTeamScore[reversedIndex].toString() + "   |   " + awayTeamScore[reversedIndex].toString()}",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             )
//                           ],
//                         )),
//                         Expanded(
//                           child: Text(
//                             awayTeam[reversedIndex].toString(),
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 15,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//     ),
//   );
// }

// Padding mainData(int index) {
//   return
// }

// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               // array=[];
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: WillPopScope(
//           // ignore: missing_return
//           onWillPop: () {
//             array1 = [];
//             array2 = [];
//           },
//           child: Container(
//             // color: Color(0xFF282a45),
//             child: ListView.builder(
//                 itemCount: array1.length,
//                 itemBuilder: (__, index) {
//                   return Container(
//                     child: Text(
//                       array2[2].toString(),
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
