import 'package:flutter/material.dart';

class cashier extends StatefulWidget {
  // const cashier({ Key? key }) : super(key: key);

  @override
  _cashierState createState() => _cashierState();
}

class _cashierState extends State<cashier> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0, 
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Cashier account",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
