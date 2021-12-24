// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hci_project/movies/moviePage.dart';
import 'package:intl/intl.dart';
// import 'package:intl';

class mainPage extends StatefulWidget {
  // const mainPage({ Key? key }) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

String movie1 =
    "https://m.media-amazon.com/images/M/MV5BMjI0NmFkYzEtNzU2YS00NTg5LWIwYmMtNmQ1MTU0OGJjOTMxXkEyXkFqcGdeQXVyMjMxOTE0ODA@._V1_.jpg";
String movie2 =
    "https://m.media-amazon.com/images/M/MV5BMWU0MGYwZWQtMzcwYS00NWVhLTlkZTAtYWVjOTYwZTBhZTBiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg";

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    // print("${d + "-" + m + "-" + y}");
    // print(DateFormat.yMd().format(DateTime.now()));
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Movies",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "Book your favorite movie",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Cards("Fast & Furious 9", "4", "Action", movie1),
              Cards("Bad Boys for Life", "5", "Action", movie2),
              Cards("Fast & Furious 9", "4", "Action", movie1),
              Cards("Bad Boys for Life", "5", "Action", movie2),
              Cards("Fast & Furious 9", "4", "Action", movie1),
              Cards("Bad Boys for Life", "5", "Action", movie2),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget Cards(
      String movieName, String movieRate, String movieGenre, String image) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => moviePages(
              movieName: movieName,
              image: image,
              rate: movieRate,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              // width: 100,
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${image}',
                  // width: 100,
                  // // height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${movieName}",
                      style: TextStyle(
                        letterSpacing: 0.4,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${movieRate.toString()}",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2, left: 2),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 17,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          DateFormat.yMd()
                              .format(DateTime.now())
                              .toString()
                              .substring(0, 5),
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      "${movieGenre}",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
