// import 'dart:html';
import 'package:football/leagues2/side%20pages/teamInfo.dart';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:football/leagues2/matchesPage.dart';
// import 'package:intl/intl.dart';

WillPopScope table(
    BuildContext context, String league_name, String league_logo) {
  for (var i in teamlogos) {
    print(i);
  }
  return WillPopScope(
    // ignore: missing_return
    onWillPop: () {
      teamsOrder = [];
      // ignore: unused_local_variable
      overall_wins = [];
      overall_draws = [];
      overall_loses = [];
      matchesPlayed = [];
      points = [];
    },
    child: Container(
      color: Color(0xFFe5e5e5),
      child: ListView.builder(
        itemCount: teamsOrder.length,
        itemBuilder: (__, index) {
          return Column(
            children: [
              Divider(
                height: 1,
              ),
              index == 0
                  ? Column(
                      children: [
                        Container(
                          color: Color(0xFFe5e5e5),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  // padding: EdgeInsets.only(left: 10),
                                  // child: Text(
                                  //   "Teams",
                                  //   style: TextStyle(
                                  //     fontSize: 15,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  ),
                              Container(
                                width: MediaQuery.of(context).size.width * .41,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PL",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "W",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "D",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "L",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "PTS",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    )
                  : SizedBox(),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => teamInfo(
                          context, teamId[index], league_name, league_logo),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              right: (index + 1) >= 10 ? 8 : 11,
                              left: (index + 1) <= 9 ? 3 : 0,
                            ),
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            child: Row(
                              children: [
                                Image.network(
                                  "${teamlogos[index]}",
                                  width: 25,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  teamsOrder[index].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              matchesPlayed[index].toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              overall_wins[index].toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              overall_draws[index].toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: points[index].length != 1 ? 0 : 4),
                              child: Text(
                                overall_loses[index].toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: points[index].length != 1 ? 0 : 4),
                              child: Text(
                                points[index].toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
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
  );
}
