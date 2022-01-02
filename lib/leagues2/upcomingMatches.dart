import 'package:flutter/material.dart';
import 'package:football/leagues2/matchesPage.dart';

WillPopScope upcomingMatches() {
  return WillPopScope(
    // ignore: missing_return
    onWillPop: () {
      empty_array();
    },
    child: Container(
      // color: Color(0xFF282a45),
      color: Color(0xFFe5e5e5),

      child:
          // isData == "false"
          //     ? Container(
          //         child: Center(
          //           child: Text(
          //             "no matches",
          //             style: TextStyle(fontSize: 20),
          //           ),
          //         ),
          //       )
          //     :
          ListView.builder(
              itemCount: homeTeam.length,
              itemBuilder: (__, index) {
                // int reversedIndex = upcomingHomeTeam.length - 1 - index;
                String convertTo12(String hhMM) {
                  if (hhMM.substring(0, 2) == "00") {
                    return "12" + ":" + hhMM.substring(3, 5);
                  } else {
                    final arr = hhMM.split(':');
                    final h = int.tryParse(arr[0]);
                    return '0${h > 12 ? h % 12 : h}:${arr[1]}';
                  }
                }

                return Padding(
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
                              upcomingHomeTeam[index].toString(),
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
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text(
                                upcomingDate[index].toString().substring(5),
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
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                convertTo12(upcomingTime[index].toString()),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                          child: Text(
                            upcomingAwayTeam[index].toString(),
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
                );
              }),
    ),
  );
}
