import 'package:flutter/material.dart';
import 'package:football/leagues2/side%20pages/matchesInfo.dart';
import 'package:football/leagues2/matchesPage.dart';

WillPopScope playedMatches(BuildContext context) {
  return WillPopScope(
    // ignore: missing_return
    onWillPop: () {
      empty_array();
    },
    child: Container(
      // color: Color(0xFF282a45),
      color: Color(0xFFe5e5e5),

      child: ListView.builder(
          itemCount: homeTeam.length,
          itemBuilder: (__, index) {
            int reversedIndex = homeTeam.length - 1 - index;
            return InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        MatchesInfo(matchId[reversedIndex].toString(), context),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Colors.grey,
                        offset: const Offset(1, 1),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            homeTeam[reversedIndex].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            child: Text(
                              matchesDate[reversedIndex]
                                  .toString()
                                  .substring(5),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Divider(height: 2, color: Colors.grey),
                          ),
                          Container(
                            child: Text(
                              homeTeamScore[reversedIndex] == ""
                                  ? "Not finished"
                                  : "${homeTeamScore[reversedIndex].toString() + "  ︱  " + awayTeamScore[reversedIndex].toString()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      )),
                      Expanded(
                        child: Text(
                          awayTeam[reversedIndex].toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    ),
  );
}
