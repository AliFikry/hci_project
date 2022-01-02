// import 'package:better_player/better_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/highlight/videoPlayerWidget.dart';
// import 'package:video_player/video_player.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }

class highlights extends StatefulWidget {
  // const highlights({ Key? key }) : super(key: key);

  @override
  _highlightsState createState() => _highlightsState();
}
// Widget highlight({Map dataa}) {
//   return
// }

class _highlightsState extends State<highlights> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF282a45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          title: Text(
            "Highlight",
            style: TextStyle(fontSize: 25),
          ),
          bottom: PreferredSize(
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Trending",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(54)),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance
                .reference()
                .child("videos/highlights"),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map data = snapshot.value;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoApp(
                                context,
                                data["link"],
                                data["title"],
                                data["date"],
                                data["competition"]),
                            // VideoPlayerWidget(context, data["link"]),
                            // Container(),
                          ),
                        );
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width * .85,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Colors.grey,
                              offset: const Offset(1, 3),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      data["title"],
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(data["competition"]),
                                  ),
                                  Container(
                                    child: Text(data["date"]),
                                    padding: EdgeInsets.all(10),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 13, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(data["thumbnail"]),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class _ref {}

// Container(
//             padding: EdgeInsets.only(top: 20),
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               children: [
//                 FirebaseAnimatedList(
//                   query: FirebaseDatabase.instance
//                       .reference()
//                       .child("videos/highlights"),
//                   itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                       Animation<double> animation, int index) {
//                     Map dataa = snapshot.value;
//                     return Container(
//                       color: Colors.yellow,
//                       width: MediaQuery.of(context).size.width * .90,
//                       height: 150,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             // flex: 2,
//                             child: Column(
//                               children: [
//                                 Text("data"),
//                                 Text("data"),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             // flex: 2,
//                             child: Column(
//                               children: [
//                                 Text(dataa["date"]),
//                                 Text("data"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                     ;
//                   },
//                 ),
//               ],
//             ),
//           ),