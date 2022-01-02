import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Query _ref;
  // Query _refTrends;
  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child("Football Transfer");
    // _refTrends = FirebaseDatabase.instance.reference().child("Football Trends");
  }

  Widget _buildTransfer({Map transfer}) {
    return Column(
      children: [
        Container(
          child: FlatButton(
            onPressed: () {
              launch(transfer["url"]);
            },
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
                          // height: MediaQuery.of(context).size.width * .20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(transfer["title"],
                                style: TextStyle(fontSize: 13)),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                transfer["source"],
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            )
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        // ignore: missing_return
        // snapshot != null &&
        //       snapshot.hasData &&
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.data != ConnectivityResult.none) {
            return FirebaseAnimatedList(
              query: _ref,
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
        });
    // FirebaseAnimatedListState(query)
  }
}


// FlatButton(
//         onPressed: () {
//           launch(news["url"]);
//         },
//         child: Column(
//           children: [
//             SizedBox(
//               height: 12.5,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               child: Image.network(
//                 news["urlImage"],
//                 width: MediaQuery.of(context).size.width,
//                 // height: MediaQuery.of(context).size.width * .20,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 news["title"],
//                 style: TextStyle(fontSize: 17),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 " ${news["source"]}",
//                 style: TextStyle(color: Color(0xFF909090), fontSize: 12),
//               ),
//             ),
//             SizedBox(
//               height: 12.5,
//             )
//           ],
//         ),
//       ),