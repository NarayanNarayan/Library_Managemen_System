import 'package:flutter/material.dart';
import 'mainadmin.dart';
import 'main.dart';
import 'package:http/http.dart';
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Issue Book',
      home: IssueBookPage(),
    );
  }
}

class IssueBookPage extends StatefulWidget {
  @override
  _IssueBookPageState createState() => _IssueBookPageState();
}

class _IssueBookPageState extends State<IssueBookPage> {
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Issue Book',
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Proper Book ID",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Book Title",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Reader ID",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Date of Issue",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Issued By",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: <Widget>[
            ButtonTheme(
              height: 50,
              disabledColor: Colors.blueAccent,
              child: RaisedButton(
                disabledElevation: 4.0,
                onPressed: null,
                child: Text(
                  'Issue Book',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: <Widget>[
            ButtonTheme(
              height: 50,
              disabledColor: Colors.blueAccent,
              child: RaisedButton(
                disabledElevation: 4.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainAdmin()));
                },
                child: Text(
                  'HomePage',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: <Widget>[
            ButtonTheme(
              height: 50,
              disabledColor: Colors.blueAccent,
              child: RaisedButton(
                disabledElevation: 4.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    )));
  }
}
