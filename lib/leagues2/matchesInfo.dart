import 'dart:convert';
import 'dart:ffi';
// import 'dart:html';
// import 'dart:html';
// import 'dart:html';
// import 'dart:html';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:football/keys/keys.dart';
import 'package:football/leagues2/matchesPage.dart';

import 'package:football/leagues2/matchesPage.dart';
import 'package:football/settings/settings.dart';
// import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:http/http.dart' as http;

var homeTeamInfo,
    awayTeamInfo,
    homeTeamLogo,
    awayTeamLogo,
    league_name,
    country_name,
    home_team_score,
    away_team_score,
    homeTeamId,
    awayTeamId,
    date,
    stadium,
    referee,
    time,
    league_logo,
    round,
    totalShot = [],
    attacks = [],
    corner = [],
    ballPossession = [],
    shotsOnGoal = [],
    yellowCard = [],
    shotsBlocked = [],
    shotsInsideBox = [],
    h2hHomeTeamScore = [],
    h2hAwayTeamScore = [],
    h2hHomeTeamName = [],
    h2hAwayTeamName = [],
    h2hMatchId = [];

dynamic goals, cards, homeSubstitutions, awaySubstitutions;
// dynamic arr;
void empty() {
  shotsOnGoal = [];
  shotsBlocked = [];
  totalShot = [];
  attacks = [];
  ballPossession = [];
  shotsInsideBox = [];
  yellowCard = [];

  h2hHomeTeamScore = [];
  h2hAwayTeamScore = [];
  h2hHomeTeamName = [];
  h2hAwayTeamName = [];
  h2hMatchId = [];
}

Widget MatchesInfo(String matchId, BuildContext context) {
  Future getData() async {
    var response = await http.get(
      Uri.http('apiv3.apifootball.com',
          '/?action=get_events&match_id=$matchId&APIkey=$apiKey'),
    );

    var data = await jsonDecode(response.body);
    homeTeamId = data[0]["match_hometeam_id"];
    awayTeamId = data[0]["match_awayteam_id"];
    var H2H = await http.get(
      Uri.http('apiv3.apifootball.com',
          '/?action=get_H2H&firstTeamId=$homeTeamId&secondTeamId=$awayTeamId&APIkey=$apiKey'),
    );
    var h2h = await jsonDecode(H2H.body);
    empty();
    // arr = h2h;
    homeTeamInfo = data[0]["match_hometeam_name"];
    awayTeamInfo = data[0]["match_awayteam_name"];
    homeTeamLogo = data[0]["team_home_badge"];
    awayTeamLogo = data[0]["team_away_badge"];
    league_name = data[0]["league_name"];
    country_name = data[0]["country_name"];
    home_team_score = data[0]["match_hometeam_ft_score"];
    away_team_score = data[0]["match_awayteam_ft_score"];
    date = data[0]["match_date"];
    round = data[0]["match_round"];
    stadium = data[0]["match_stadium"];
    referee = data[0]["match_referee"];
    time = data[0]["match_time"];
    league_logo = data[0]["league_logo"];

    totalShot.add(data[0]["statistics"][9]["home"]);
    totalShot.add(data[0]["statistics"][9]["away"]);

    shotsOnGoal.add(data[0]["statistics"][10]["home"]);
    shotsOnGoal.add(data[0]["statistics"][10]["away"]);

    shotsBlocked.add(data[0]["statistics"][12]["home"]);
    shotsBlocked.add(data[0]["statistics"][12]["away"]);

    shotsInsideBox.add(data[0]["statistics"][13]["home"]);
    shotsInsideBox.add(data[0]["statistics"][13]["away"]);

    ballPossession
        .add(data[0]["statistics"][18]["home"].toString().substring(0, 2));
    ballPossession
        .add(data[0]["statistics"][18]["away"].toString().substring(0, 2));
    attacks.add(data[0]["statistics"][5]["home"]);
    attacks.add(data[0]["statistics"][5]["away"]);
    yellowCard.add(data[0]["statistics"][19]["home"]);
    yellowCard.add(data[0]["statistics"][19]["away"]);
    corner.add(data[0]["statistics"][16]["home"]);
    corner.add(data[0]["statistics"][16]["away"]);
    // goalScorer.add(data[0]["goalscorer"]);

    goals = data[0]["goalscorer"];
    cards = data[0]["cards"];
    homeSubstitutions = data[0]["substitutions"]["home"];
    awaySubstitutions = data[0]["substitutions"]["away"];

    // print(data[0]["goalscorer"]);
    for (var i = 0; i < h2h["firstTeam_VS_secondTeam"].length; i++) {
      h2hMatchId.add(h2h["firstTeam_VS_secondTeam"][i]["match_id"]);
      h2hHomeTeamName
          .add(h2h["firstTeam_VS_secondTeam"][i]["match_hometeam_name"]);
      h2hAwayTeamName
          .add(h2h["firstTeam_VS_secondTeam"][i]["match_awayteam_name"]);
      h2hHomeTeamScore
          .add(h2h["firstTeam_VS_secondTeam"][i]["match_hometeam_score"]);
      h2hAwayTeamScore
          .add(h2h["firstTeam_VS_secondTeam"][i]["match_awayteam_score"]);
    }
    print(h2h);
  }

  getData().then((value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Info(matchId: matchId),
        ),
      ));
  // do {

  // } while (h2hHomeTeamName.length == 0);
  // if (h2hHomeTeamName.length == 0) {
  //   test();
  // }

  return Center(
    child: CircularProgressIndicator(
      color: Color(0xFF282a45),
    ),
  );
}

class Info extends StatefulWidget {
  final String matchId;
  const Info({this.matchId}) : super();

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    // gett();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .27),
        child: Container(
          color: Color(0xFFe5e5e5),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            elevation: 0,
            backgroundColor: Color(0xFF282a45),
            leading: InkWell(
              onTap: () {
                empty();
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              "${country_name + " - " + league_name + " " + widget.matchId}",
              style: TextStyle(fontSize: 18),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.network(
                          homeTeamLogo,
                          width: 60,
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * .35,
                          child: Center(
                            child: Text(
                              homeTeamInfo,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "${home_team_score + " - " + away_team_score}",
                            style: TextStyle(color: Colors.white, fontSize: 27),
                          ),
                          SizedBox(height: 7),
                          Text(
                            date.toString().substring(5),
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Image.network(
                          awayTeamLogo,
                          width: 60,
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * .35,
                          child: Center(
                            child: Text(
                              awayTeamInfo,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFe5e5e5),
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Status",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: 110,
                child: Divider(
                  height: 3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  // color: Colors.green,
                  decoration: BoxDecoration(
                    color: Color(0xFF282a45),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      details("Shots", totalShot, context),
                      details("Possession", ballPossession, context),
                      details("Attacks", attacks, context),
                      details("Yellow cards", yellowCard, context),
                      details("Corner", corner, context),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF282a45),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Shots",
                        style: TextStyle(color: Colors.white),
                      ),
                      Column(
                        children: [
                          // details("Total shots", totalShot, context),
                          details("On goal", shotsOnGoal, context),
                          // details("Off goal", shotsOffGoal, context),
                          details("Blocked", shotsBlocked, context),
                          details("Inside box", shotsInsideBox, context),
                          // details("Outside box", shotsOutsideBox, context),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              events(context),
              gameInfo(context),
              // SizedBox(height: 10),
              //ListView.builder(
              //itemCount: arr[0]["goalscorer"],
              // itemBuilder: (__, index) {
              //   return Container(
              //    child: arr[0]["goalscorer"][index]["time"],
              //  );
              // },
              //),
              h2hHomeTeamName == null ? SizedBox() : H2H(),

              // Image.network(homeTeamLogo)
            ],
          ),
        ),
      ),
    );
  }

  Container events(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .70,
      // padding: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => showModalBottomSheet(
          backgroundColor: Color(0xFFe5e5e5),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
          context: context,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            builder: (__, index) => ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(10)),
                    // child: Text("data"),
                  ),
                ),
                //goals
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Goals",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.left,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            FontAwesome.times_circle,
                            color: Colors.red[300],
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 60,
                //   child: Divider(height: 1, color: Colors.black),
                // ),
                SizedBox(height: 10),
                goals.length == 0
                    ? Center(
                        child: Text(
                          "No goals in this match",
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: goals.length,
                        itemBuilder: (__, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: goals[index]["home_scorer"] == ""
                                          ? SizedBox()
                                          : Text(
                                              goals[index]["home_scorer"],
                                              textAlign: TextAlign.center,
                                            ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${goals[index]["time"]} '",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: goals[index]["away_scorer"] == ""
                                          ? SizedBox()
                                          : Text(
                                              goals[index]["away_scorer"],
                                              textAlign: TextAlign.center,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                            ],
                          );
                        },
                      ),
                //cards

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Cards",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 15),
                    cards.length == 0
                        ? Center(
                            child: Text(
                              "No cards in this match",
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cards.length,
                            itemBuilder: (__, index2) {
                              // testt();
                              // print(cards[index2]["home_fault"]);
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      // padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: cards[index2]
                                                        ["home_fault"] ==
                                                    ""
                                                ? SizedBox()
                                                : Text(
                                                    cards[index2]["home_fault"],
                                                    textAlign: TextAlign.center,
                                                  ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 15,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    color: cards[index2]
                                                                ["card"] ==
                                                            "yellow card"
                                                        ? Colors.yellow
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "${cards[index2]["time"] + "'"}",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: cards[index2]
                                                        ["away_fault"] ==
                                                    ""
                                                ? SizedBox()
                                                : Text(
                                                    cards[index2]["away_fault"],
                                                    textAlign: TextAlign.center,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.black,
                                  )
                                ],
                              );
                            },
                          ),
                  ],
                ),
                //sub
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Substitution",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //home sub
                    Column(
                      children: [
                        Text(
                          "Home team",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: homeSubstitutions.length,
                          itemBuilder: (__, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              ShaderMask(
                                                blendMode: BlendMode.srcATop,
                                                // ignore: missing_return
                                                shaderCallback: (bounds) =>
                                                    LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  stops: [0.3, 1],
                                                  colors: [
                                                    Colors.green[700],
                                                    Colors.red[300],
                                                  ],
                                                ).createShader(bounds),
                                                child: Icon(
                                                  MaterialCommunityIcons
                                                      .autorenew,
                                                  size: 30,
                                                ),
                                              ),
                                              SizedBox(width: 7),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${homeSubstitutions[index]["substitution"].toString().substring(
                                                          0,
                                                          homeSubstitutions[
                                                                      index][
                                                                  "substitution"]
                                                              .toString()
                                                              .indexOf("|"),
                                                        )}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "${homeSubstitutions[index]["substitution"].toString().substring(homeSubstitutions[index]["substitution"].toString().indexOf("|") + 2)}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${homeSubstitutions[index]["time"] + "'"}",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black,
                                    height: 1,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        // Divider(
                        //   height: 1,
                        //   color: Colors.black,
                        // )
                      ],
                    ),
                    //away sub
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Away team",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: awaySubstitutions.length,
                          itemBuilder: (__, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.max,
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${awaySubstitutions[index]["time"] + "'"}",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              // SizedBox(width: 7),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${awaySubstitutions[index]["substitution"].toString().substring(
                                                          0,
                                                          awaySubstitutions[
                                                                      index][
                                                                  "substitution"]
                                                              .toString()
                                                              .indexOf("|"),
                                                        )}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "${awaySubstitutions[index]["substitution"].toString().substring(awaySubstitutions[index]["substitution"].toString().indexOf("|") + 2)}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(width: 7),
                                              ShaderMask(
                                                blendMode: BlendMode.srcATop,
                                                // ignore: missing_return
                                                shaderCallback: (bounds) =>
                                                    LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  stops: [0.3, 1],
                                                  colors: [
                                                    Colors.green[700],
                                                    Colors.red[300],
                                                  ],
                                                ).createShader(bounds),
                                                child: Icon(
                                                  MaterialCommunityIcons
                                                      .autorenew,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black,
                                    height: 1,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        // Divider(
                        //   height: 1,
                        //   color: Colors.black,
                        // )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Match Detail",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward_ios, size: 14)
          ],
        ),
      ),
    );
  }

  Widget H2H() {
    return Column(
      children: [
        Text(
          "Head to head",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: 140,
          child: Divider(
            height: 3,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 55,
          child: ListView.builder(
            itemCount: h2hHomeTeamName.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         MatchesInfo(matchId[index].toString(), context),
                    //   ),
                    // );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          spreadRadius: 1,
                          color: Colors.grey,
                          offset: const Offset(1, 1),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          homeTeamLogo,
                          width: 40,
                          // height: 30,
                        ),
                        Text(
                          "${h2hHomeTeamScore[index] + " - " + h2hAwayTeamScore[index]}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Image.network(
                          awayTeamLogo,
                          width: 40,
                          // height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Padding gameInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF282a45),
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
              child: Text(
                "Game Info",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(height: 1, color: Colors.white),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  FontAwesome.clock_o,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "${date.toString().substring(5) + "  " + time}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  FontAwesome.hashtag,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "${league_name + " - " + "Round " + round}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  MaterialCommunityIcons.whistle,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "${referee}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  MaterialCommunityIcons.stadium,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "${stadium}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget details(String event, List array, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width * .30,
              child: Text(
                array[0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              "$event",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              array[1],
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}






// ExpansionTile(
//                   title: Text("data"),
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: goals.length,
//                       itemBuilder: (__, index) {
//                         return Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(4),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: goals[index]["home_scorer"] == ""
//                                         ? SizedBox()
//                                         : Text(
//                                             goals[index]["home_scorer"],
//                                             textAlign: TextAlign.center,
//                                           ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "${goals[index]["time"]} '",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: goals[index]["away_scorer"] == ""
//                                         ? SizedBox()
//                                         : Text(
//                                             goals[index]["away_scorer"],
//                                             textAlign: TextAlign.center,
//                                           ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               height: 1,
//                               color: Colors.black,
//                             )
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 )