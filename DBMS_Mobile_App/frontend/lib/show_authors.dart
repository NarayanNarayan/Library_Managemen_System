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
      title: 'Show Authors',
      home: ShowAuthorPage(),
    );
  }
}

class ShowAuthorPage extends StatefulWidget {
  @override
  _ShowAuthorPageState createState() => _ShowAuthorPageState();
}

class _ShowAuthorPageState extends State<ShowAuthorPage> {
  DateTime _dateTime;
  List<dynamic> data = [];
  List<String> line = [];
  String col;
  List<DataCell> cells = [];
  DataRow row;
  List<DataRow> rowss = [];
  void getData(Map<String, dynamic> qdata) async {
    var url = Uri.http(session.ip, '/lib/show_authors/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      if (jsonResponse['success']) {
        data = jsonResponse['result'];
        print(data.length);
        for (var j = 0; j < data.length; j++) {
          cells.clear();
          for (var i = 0; i < 9; i++) {
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
          label: Text('Author ID'),
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
          label: Text('Email'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Address'),
          numeric: false,
        ),
        DataColumn(
          label: Text('City'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Pin'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Phone0'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Phone1'),
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
              'Show Authors',
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
        ),
        Column(
          children: <Widget>[
            Container(
              child: bodyData(),
            )
          ],
        ),
      ],
    )));
  }
}
