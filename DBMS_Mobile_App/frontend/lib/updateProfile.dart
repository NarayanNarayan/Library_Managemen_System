import 'package:flutter/material.dart';
import 'changepwd.dart';
import 'mainuser.dart';
import 'main.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Profile',
      home: UpdateProfilePage(),
    );
  }
}

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  DateTime _dateTime;
  String name = '',
      username = '',
      email = '',
      phone0 = '',
      phone1 = '',
      addr = '',
      city = '',
      pin = '';
  void setData(Map<String, dynamic> qdata) async {
    var url = Uri.http(session.ip, '/lib/updateprofiler/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      if (jsonResponse['success']) {
        session.uname = name;
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
              'Update Profile',
              style: TextStyle(fontSize: 25, color: Colors.green),
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
                          builder: (context) => ChangePassword()));
                },
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: name),
          decoration: InputDecoration(
            labelText: "Name",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              name = text;
            });
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          //controller: TextEditingController(text: username),
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
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: email),
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              email = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: phone0),
          decoration: InputDecoration(
            labelText: "Phone",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              phone0 = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: phone1),
          decoration: InputDecoration(
            labelText: "Phone(Optional)",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              phone1 = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: addr),
          decoration: InputDecoration(
            labelText: "Address",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              addr = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: city),
          decoration: InputDecoration(
            labelText: "City",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              city = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          //controller: TextEditingController(text: pin),
          decoration: InputDecoration(
            labelText: "Pincode",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              pin = text;
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
                  setData({
                    'rid': session.rid.toString(),
                    'name': name,
                    'username': username,
                    'email': email,
                    'phone0': phone0,
                    'phone1': phone1,
                    'addr': addr,
                    'city': city,
                    'pin': pin
                  });
                },
                child: Text(
                  'Update',
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
                      MaterialPageRoute(builder: (context) => MainUser()));
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
