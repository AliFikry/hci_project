import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football/accountForm/auth.dart';
import 'package:football/accountForm/login.dart';
import 'package:football/main.dart';
import 'package:football/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

// ignore: camel_case_types
class Matches extends StatefulWidget {
  @override
  _MatchesState createState() => _MatchesState();
}

String B;
String list = "All";
final AuthenticationService _auth = AuthenticationService();

// ignore: camel_case_types
class _MatchesState extends State<Matches> {
  // ignore: deprecated_member_use
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  DatabaseReference itemRef2;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SearchMethod2(list);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  void SearchMethod2(name) {
    item = Item("", "", "", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef =
        database.reference().child("matches").child("All Matches").child(name);
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    itemRef2 = database.reference().child("matches").child("All Matches");
    itemRef2.onChildAdded.listen(_onEntryAdded);
    itemRef2.onChildChanged.listen(_onEntryChanged);
    items.clear();
  }

  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  Future<void> _launched;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text("widget.name", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () async {
              await _auth.signOut();

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WelcomePage()));
            },
            icon: Icon(FontAwesome.bars),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container()
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(4.0),
        //       child: Container(
        //         decoration: BoxDecoration(
        //             border: Border.all(color: Colors.black12),
        //             borderRadius: BorderRadius.circular(5)
        //         ),
        //         height: 60,
        //         width: MediaQuery.of(context).size.width,
        //         child: Center(
        //           child: FirebaseAnimatedList(
        //             scrollDirection: Axis.horizontal,
        //             query: itemRef2,
        //             itemBuilder: (BuildContext context, DataSnapshot snapshot,
        //                 Animation<double> animation, int index) {
        //               var selectedIndex= snapshot.key;
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: GestureDetector(
        //                   onTap: () {
        //                     setState(() {
        //                       selectedIndex=snapshot.key;
        //                     });
        //                     list = snapshot.key;
        //                     print(list);
        //                     SearchMethod2(list);
        //                   },
        //                   child:ClipRRect(
        //                     borderRadius: BorderRadius.circular(8),
        //                     child: Container(
        //                       color:selectedIndex == list ?Colors.deepOrangeAccent:Colors.white,
        //                       width: 90,
        //                       child: Center(child: Text(snapshot.key,textAlign: TextAlign.center,)),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //         height: MediaQuery.of(context).size.height*0.55,
        //         child:Scrollbar(
        //           isAlwaysShown: true,
        //           thickness: 10,
        //           radius:Radius.circular(5),
        //           child: ListView.builder(
        //             // physics: NeverScrollableScrollPhysics(),
        //             itemCount: items.length,
        //             itemBuilder:(context, index) {
        //               return Column(
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(4.0),
        //                     child: Container(
        //                       child: Row(
        //                         children: [
        //
        //                           SizedBox(
        //                             width: 10,
        //                           ),
        //                           Spacer(),
        //                           Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Container(
        //                               alignment: Alignment.centerRight,
        //                               width: 180,
        //                               child: Column(
        //                                 children: [
        //                                   // Text(
        //                                   //   // items[index].name,
        //                                   //   style: TextStyle(
        //                                   //       fontWeight: FontWeight.w800,
        //                                   //       fontSize: 15),
        //                                   //   textAlign: TextAlign.right,
        //                                   // ),
        //                                   Container(
        //                                     // child: Text(
        //                                     //   items[index].detail,
        //                                     //   style: TextStyle(
        //                                     //       fontWeight: FontWeight.w500,
        //                                     //       fontSize:10),
        //                                     //   textAlign: TextAlign.right,
        //                                     // ),
        //                                   ),
        //                                 ],
        //                                 crossAxisAlignment:
        //                                 CrossAxisAlignment.end,
        //                               ),
        //                             ),
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: ClipRRect(
        //                               child: Container(
        //                                 // child: Image.network(
        //                                 //  " items[index].image",
        //                                 //   fit: BoxFit.fill,
        //                                 // ),
        //                                 height: 70,
        //                                 width: 70,
        //                               ),
        //                               borderRadius: BorderRadius.circular(10),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   Divider(
        //                     height: 3,
        //                   ),
        //                 ],
        //               );
        //             }, ),
        //         )
        //     ),
        //   ],
        // ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.green,
        //   child: IconButton(icon: Icon(Icons.call), onPressed: (){setState(() {
        //     _launched = _makePhoneCall('tel:${widget.number}');
        //   });}),
        // ),
        );
  }
}

class Item {
  String key;
  String name;
  String image;
  String detail;
  var priceL;
  var priceM;
  var priceS;
  var price;

  Item(this.name, this.image, this.detail, this.priceL, this.priceM,
      this.priceS, this.price);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        image = snapshot.value["image"],
        detail = snapshot.value["detail"],
        priceS = snapshot.value["priceS"],
        priceM = snapshot.value["priceM"],
        priceL = snapshot.value["priceL"],
        price = snapshot.value["price"];
}




//
//
//
//
//
// class Matches extends StatefulWidget {
//   @override
//   _MatchesState createState() => _MatchesState();
// }
//
// // String leagues = "All Teams";
//
// class _MatchesState extends State<Matches> {
//   // ignore: deprecated_member_use
//   // List<Item> items = List();
//   // Item item;
//   // DatabaseReference itemRef;
//   // DatabaseReference itemRef2;
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   Query _ref;
//   @override
//   void initState() {
//     super.initState();
//     // searchMethod(leagues);
//
//     _ref = FirebaseDatabase.instance
//         .reference()
//         .child("matches")
//         .child("All Matches");
//   }
//
//   Widget _buildmatches({Map matches, var key}) {
//     return Container(
//       child: Text('${matches}'),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           title: Text("Matches"),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (context) => Settings()));
//             },
//             icon: Icon(FontAwesome.bars),
//           ),
//         ),
//         body: Container(
//           child: ExpansionTile(
//             title: Text("league"),
//             children: [
//               Text("test"),
//               Text("test"),
//               Text("test"),
//               Text("test"),
//             ],
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
