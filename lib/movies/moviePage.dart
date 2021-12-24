// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hci_project/movies/checkout.dart';

class moviePages extends StatefulWidget {
  final String movieName;
  final String image;
  final String rate;
  const moviePages(
      {required this.movieName, required this.image, required this.rate})
      : super();

  @override
  _moviePagesState createState() => _moviePagesState();
}

class _moviePagesState extends State<moviePages> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            widget.movieName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.image,
                      width: MediaQuery.of(context).size.width * .60,
                    ),
                  ),
                ),
                ////////// stars sections //////
                const SizedBox(height: 15),

                ///
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .30),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (__, index) {
                            return Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ],
                            );
                          },
                          itemCount: int.parse(widget.rate),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (__, index) {
                            return Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            );
                          },
                          itemCount: 5 - int.parse(widget.rate),
                        ),
                      ],
                    ),
                  ),
                ),
                ///////////////////////movie informations //////////////
                const SizedBox(height: 20),

                ///

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "27",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Date",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "07:30",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Hour",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.4, color: Colors.grey),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              "Seats available",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "40",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /////////////////last button and price//////////////
                ///

                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "price",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "\$70",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => checkout(
                                name: widget.movieName,
                                image: widget.image,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(9)),
                          child: const Text(
                            "Booking",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
