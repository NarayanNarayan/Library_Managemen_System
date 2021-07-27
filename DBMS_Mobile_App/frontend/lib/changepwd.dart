import 'package:flutter/material.dart';
import 'main.dart';
import 'mainuser.dart';
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
      title: 'Change Pwd',
      home: ChangePassword(),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String pwd, cpwd;
  void setData(Map<String, dynamic> qdata) async {
    var url = Uri.http('192.168.1.32:8000', '/lib/chpwd/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      if (jsonResponse['success']) {
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
              'Change Password',
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
          ],
        ),
        SizedBox(
          height: 60.0,
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
              pwd = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              cpwd = text;
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
                  setData({'rid': session.rid.toString(), 'pwd': pwd});
                },
                child: Text(
                  'Change',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        )
      ],
    )));
  }
}
