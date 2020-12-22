import 'dart:io';

import 'package:adrian_kenya/models/scholarship_listing.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Available extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(title: Text(
          "Scholarship"
      )),
      body: AvailableScholarship(),
    );
  }
}

class AvailableScholarship extends StatefulWidget {
  @override
  _AvailableScholarshipState createState() => _AvailableScholarshipState();
}

class _AvailableScholarshipState  extends State<AvailableScholarship> {

  final String url = "https://geoproserver.herokuapp.com/api/sponsorship";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {

    var response = await http.get(
        Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwidXNlcm5hbWUiOiJHaWRkaWUiLCJlbWFpbCI6ImdpZGVvbm9sbG9uZGVAZ21haWwuY29tIiwiZXhwIjoxNjA5MTQ3ODY0LCJpc19zdGFmZiI6ZmFsc2V9.k6ZzzSXb8pOSLJvYH-PDa8ndkTlWeb4-ARwH9590NP0"},
    );
    print(response.body);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['results'];
    });
    return "Success";
  }

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
    // fetchSponsorships().then((value) {
    //   setState(() {
    //     _sponsorships.addAll(value);
    //   });
    // });

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Container(
        height: _height,
        width: _width,

        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget> [
                    new Card(
                      child: new Container(
                        child: new Text(data[index]['name']),
                        padding: const EdgeInsets.all(20.0),
                      ),
                    )
                  ]
                ),
              )
            );
          },
        ),
      ),
    );
  }
}
