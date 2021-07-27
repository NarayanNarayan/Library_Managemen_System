import 'package:flutter/material.dart';
import 'searchbook.dart';
import 'adminlogin.dart';
import 'usersignin.dart';
import 'package:http/http.dart';
import 'dart:convert';

class session {
  static int rid;
  static String uname;
  static int adid;
  static String ip = '192.168.1.32:8000';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              'Welcome to',
              style: TextStyle(fontSize: 25, color: Colors.green),
            ),
            Text(
              'Library Management System',
              style: TextStyle(fontSize: 35, color: Colors.green),
            )
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        Column(
          children: <Widget>[
            ButtonTheme(
              height: 50,
              disabledColor: Colors.blueAccent,
              child: RaisedButton(
                disabledElevation: 4.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminLoginPage()));
                },
                child: Text(
                  'Admin Sign In',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 50,
              disabledColor: Colors.blueAccent,
              child: RaisedButton(
                disabledElevation: 4.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchBookPage()));
                },
                child: Text(
                  'Search Books',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 50,
              disabledColor: Colors.blueAccent,
              child: RaisedButton(
                disabledElevation: 4.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserLoginPage()));
                },
                child: Text(
                  'User Sign In',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        )
      ],
    )));
  }
}
