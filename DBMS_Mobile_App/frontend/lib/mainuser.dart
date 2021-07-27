import 'package:flutter/material.dart';
import 'updateProfile.dart';
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
      title: 'User\'s HomePage',
      home: MainUser(),
    );
  }
}

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
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
              'User\'s HomePage',
              style: TextStyle(fontSize: 25, color: Colors.green),
            ),
            Text(
              'Hello  '+session.uname+'!',
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
                          builder: (context) => UpdateProfilePage()));
                },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
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
              print(session.rid);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              'LogOut',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        )
      ],
    )));
  }
}
