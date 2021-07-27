import 'package:flutter/material.dart';
import 'package:studio_flutter_app/mainuser.dart';
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
      title: 'SignUp App',
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  DateTime _dateTime;
  
  String username = '', password = '';
  void getData(Map<String, dynamic> qdata) async {
    var url = Uri.http(session.ip, '/lib/adminlogin/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        session.adid=jsonResponse['rid'];
        session.uname=jsonResponse['uname'];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainUser()));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
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
              'User Sign Up',
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Name",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Username",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Phone",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Phone(Optional)",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Address",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "City",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Pincode",
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
                  'Create Account',
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
