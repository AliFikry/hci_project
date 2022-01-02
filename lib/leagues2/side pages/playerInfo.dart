import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football/keys/keys.dart';
import 'package:http/http.dart' as http;

dynamic arr;

Widget playerInfo(BuildContext context, String playerId, String teamLogo) {
  Future getData() async {
    var respone = await http.get(
      Uri.http("apiv3.apifootball.com",
          "/?action=get_players&player_id=${playerId}&APIkey=$apiKey"),
    );
    var data = jsonDecode(respone.body);
    arr = data;
    // print(data.last["team_name"]);
  }

  getData().then((value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PlayerInfo(
            playerId: playerId,
            teamBadge: teamLogo,
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

class PlayerInfo extends StatefulWidget {
  final String playerId;
  final String teamBadge;
  const PlayerInfo({this.playerId, this.teamBadge}) : super();

  @override
  _PlayerInfoState createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {
  @override
  Widget build(BuildContext context) {
    print(arr.last["player_type"]);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF282a45),
          leading: InkWell(
            onTap: () {
              // Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          bottom: PreferredSize(
            child: Column(
              children: [
                // img(arr.last["player_image"]),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network("${arr.last["player_image"]}"),
                ),
                SizedBox(height: 15),
                Text(
                  arr.last["player_name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * .30),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: Color(0xFFe5e5e5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      arr.last["player_number"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Number",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    color: Colors.black,
                                    width: 100,
                                    height: 1,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      arr.last["player_rating"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black,
                              width: 1,
                              height: 100,
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      arr.last["player_age"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "age",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    color: Colors.black,
                                    width: 100,
                                    height: 1,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      arr.last["player_type"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Posotion",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black,
                              width: 1,
                              height: 100,
                            ),
                            Column(
                              children: [
                                Image.network(
                                  widget.teamBadge,
                                  width: 50,
                                  height: 60,
                                ),
                                Text(arr.last["team_name"]),
                                SizedBox(height: 10),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 3,
                      ),
                      Container(
                        child: Column(
                          children: [
                            details(
                                title: "Matches played",
                                arr: arr.last["player_match_played"]),
                            arr.last["player_type"] != "Goalkeepers"
                                ? details(
                                    title: "Goals",
                                    arr: arr.last["player_goals"])
                                : SizedBox(),
                            arr.last["player_type"] == "Goalkeepers"
                                ? Column(
                                    children: [
                                      details(
                                          title: "Saves",
                                          arr: arr.last["player_saves"]),
                                      details(
                                          title: "Goals conceded",
                                          arr: arr
                                              .last["player_goals_conceded"]),
                                    ],
                                  )
                                : SizedBox(),
                            details(
                                title: "Yellow cards",
                                arr: arr.last["player_yellow_cards"]),
                            details(
                                title: "Red cards",
                                arr: arr.last["player_red_cards"]),
                            details(
                                title: "Minutes played",
                                arr: arr.last["player_minutes"]),
                            details(
                                title: "Substitute out",
                                arr: arr.last["player_substitute_out"]),
                            details(
                                title: "Substitutes on bench",
                                arr: arr.last["player_substitutes_on_bench"]),
                            details(
                                title: "Assists",
                                arr: arr.last["player_assists"]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class details extends StatelessWidget {
  final String title;
  final dynamic arr;
  const details({
    this.title,
    this.arr,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(
                flex: 2,
                child: Text(
                  arr.toString(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * .85,
          color: Colors.black,
        )
      ],
    );
  }
}
