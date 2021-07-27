import 'package:flutter/material.dart';
import 'package:studio_flutter_app/mainadmin.dart';
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
      title: 'Admin Login',
      home: AdminLoginPage(),
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  String username = '', password = '';
  void getData(Map<String, dynamic> qdata) async {
    var url = Uri.http(session.ip, '/lib/adminlogin/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        session.adid=jsonResponse['adid'];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainAdmin()));
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
              'Admin Sign In',
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Username",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              username = text;
            });
          },
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
          onChanged: (text) {
            setState(() {
              password = text;
            });
          },
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
                  getData({'username': username, 'password': password});
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
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
                  'HomePage',
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
