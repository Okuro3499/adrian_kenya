import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Applications"
        ),
      ),
      body: ApplicationsPg(),
    );
  }
}

class ApplicationsPg extends StatefulWidget {
  @override
  _ApplicationsPgState createState() => _ApplicationsPgState();
}

class _ApplicationsPgState extends State<ApplicationsPg> {

  final String url = "https://geoproserver.herokuapp.com/api/applications";
  List data = [];

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjA5NzY2NzU4LCJpc19zdGFmZiI6dHJ1ZX0.e8QzJ4R04LHIWlwd4Qm8AQ5JhSP87Ezxc1_aGDFVj-o"},
    );

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
    });
    // showDialog(
    //     context: context,
    //     builder: (_) => AlertDialog(
    //       title: Text('Approve'),
    //       content: Text('Kindly Accept or Decline application to proceed'),
    //       actions: <Widget>[
    //         FlatButton(
    //           child: Text('Accept'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         FlatButton(
    //           child: Text('Decline'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         )
    //       ],
    //     )
    // );
    return "Success";
  }

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
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
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only (top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data[index]['student'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['mobile'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['country'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['city'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['school_name'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['degree'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['cover_letter'],
                        style: TextStyle(fontSize: 15)),
                    // Text(data[index]['start'],
                    //     style: TextStyle(fontSize: 15)),
                    // Text(data[index]['to'],
                    //     style: TextStyle(fontSize: 15)),
                    Text(data[index]['postal_code'],
                        style: TextStyle(fontSize: 15)),
                    // Text(data[index]['birth_certificate'],
                    //     style: TextStyle(fontSize: 15,)),
                    Text(data[index]['national_id'],
                        style: TextStyle(fontSize: 15)),
                    Text(data[index]['email'],
                        style: TextStyle(fontSize: 15,)),
                    Text(data[index]['sponsorship_name'],
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            );
          },
          itemCount: data.length,
        ),
      ),
    );
  }
}
