import 'dart:core';
import 'dart:ffi';
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
      title: 'Add Admin',
      home: ShowAdminPage(),
    );
  }
}

class ShowAdminPage extends StatefulWidget {
  @override
  _ShowAdminPageState createState() => _ShowAdminPageState();
}

class _ShowAdminPageState extends State<ShowAdminPage> {
  DateTime _dateTime;
  List<dynamic> data = [];
  List<String> line = [];
  String col;
  List<DataCell> cells = [];
  DataRow row;
  List<DataRow> rowss = [];
  void getData(Map<String, dynamic> qdata) async {
    var url = Uri.http(session.ip, '/lib/show_admins/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      if (jsonResponse['success']) {
        data = jsonResponse['result'];
        print(data.length);
        for (var j = 0; j < data.length; j++) {
          cells.clear();
          for (var i = 0; i < 13; i++) {
            setState(() {
              cells.add(DataCell(Text(data[j][i].toString())));
            });
          }
          setState(() {
            rowss.add(DataRow(cells: List.from(cells)));
          });
        }
        print(rowss.length);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Widget bodyData() => DataTable(columns: <DataColumn>[
        DataColumn(
          label: Text('ID'),
          numeric: false,
        ),
        DataColumn(
          label: Text('username'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Password'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Name'),
          numeric: false,
        ),
        DataColumn(
          label: Text('DOB'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Post'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Salary'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Email'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Phone'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Phonne1'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Address'),
          numeric: false,
        ),
        DataColumn(
          label: Text('city'),
          numeric: false,
        ),
        DataColumn(
          label: Text('pincode'),
          numeric: false,
        ),
      ], rows: rowss);

  @override
  void initState() {
    getData({});
    super.initState();
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
                  'Show Staff Member',
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
                Container(
                  child: bodyData(),
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
                      'Logout',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShowAdmin {
  String ID;
  String username;
  String password;
  String name;
  String dob;
  String post;
  String salary;
  String email;
  String phone0;
  String phone1;
  String address;
  String city;
  String pincode;

  ShowAdmin(
      {this.ID,
      this.username,
      this.password,
      this.name,
      this.dob,
      this.post,
      this.salary,
      this.email,
      this.phone0,
      this.phone1,
      this.address,
      this.city,
      this.pincode});
}
