import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      title: 'Search Book',
      home: SearchBookPage(),
    );
  }
}

class SearchBookPage extends StatefulWidget {
  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

List<Widget> rows = [
  Row(
    children: <Widget>[
      Text(
        'Book Id',
      ),
      Text(
        'Book Title',
      ),
      Text(
        'Category',
      ),
      Text(
        'Author',
      ),
      Text(
        'Publisher',
      ),
    ],
  ),
];

class _SearchBookPageState extends State<SearchBookPage> {
  String bid = '', bname = '', category = '', auth = '', publisher = '';
  List<dynamic> data = [];
  List<String> line = [];
  String col;
  List<DataCell> cells = [];
  DataRow row;
  List<DataRow> rowss = [];
  void getData(Map<String, dynamic> qdata) async {
    var url = Uri.http(session.ip, '/lib/show_readers/', qdata);
    Response response = await get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      if (jsonResponse['success']) {
        data = jsonResponse['result'];
        print(data.length);
        for (var j = 0; j < data.length; j++) {
          cells.clear();
          for (var i = 0; i < 5; i++) {
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

  void search() {
    getData({
      'bid': bid,
      'bname': bname,
      'category': category,
      'auth': auth,
      'publisher': publisher,
    } as Map<String, dynamic>);
  }

  DateTime _dateTime;

  Widget bodyData() => DataTable(columns: <DataColumn>[
        DataColumn(
          label: Text('Book ID'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Title'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Category'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Author'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Publisher'),
          numeric: false,
        ),
      ], rows: rowss);

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
              'Search Book',
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
          ],
        ),
        SizedBox(
          height: 60,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Book ID",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              bid = text;
            });
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Book Title",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              bname = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Category",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              category = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Author",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              auth = text;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Publisher",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          onChanged: (text) {
            setState(() {
              publisher = text;
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
                onPressed: search,
                child: Text(
                  'Search',
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
                  'HomePage',
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
