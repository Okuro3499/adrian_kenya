import 'dart:io';

import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../login_screen.dart';
import 'form.dart';
import 'home.dart';

class Available extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Scholarships"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(),
            ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                })
          ],
        ),
      ),
      body: AvailableScholarship(),
    );
  }
}

class AvailableScholarship extends StatefulWidget {
  @override
  _AvailableScholarshipState createState() => _AvailableScholarshipState();
}

class _AvailableScholarshipState extends State<AvailableScholarship> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  final String url = "https://geoproserver.herokuapp.com/api/sponsorship";
  List data = [];

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwidXNlcm5hbWUiOiJHaWRkaWUiLCJlbWFpbCI6ImdpZGVvbm9sbG9uZGVAZ21haWwuY29tIiwiZXhwIjoxNjEyMzM5MjA0LCJpc19zdGFmZiI6ZmFsc2V9.Vr9ZM9I7M6_iuhG04ztLERw1rw1ilQdThlN3piaI0mA"
      },
    );

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
    });
    return "Success";
  }

  Future<bool> _onWillPop() async {
    return (Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Home();
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        child: Scaffold(
          body: Container(
            height: _height,
            width: _width,
            child: ListView.builder(
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {});
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              FormPg(scholarship_id: data[index]['pk'])),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data[index]['name'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(data[index]['description'],
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: data.length,
            ),
          ),
        ),
      ),
    );
  }
}
