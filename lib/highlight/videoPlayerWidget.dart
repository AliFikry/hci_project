// import 'dart:html';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget VideoApp(BuildContext context, String link, String title, String date,
    String competition) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF282a45),
        title: Text(
          "Highlights",
          style: TextStyle(fontSize: 18),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .30,
              child: WebView(
                initialUrl: link == null ? CircularProgressIndicator() : link,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            info(context, "Competition", competition),
            info(context, "Teams", title),
            info(context, "Date", date),
          ],
        ),
      ),
    ),
    debugShowCheckedModeBanner: false,
  );
}

Widget info(BuildContext context, String title, String data) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Text(
              data,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      Divider(
        height: 1,
      ),
    ],
  );
}
