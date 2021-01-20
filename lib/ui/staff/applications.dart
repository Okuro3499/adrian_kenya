import 'package:adrian_kenya/ui/staff/created.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications"),
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
    var response = await http.get(Uri.encodeFull(url), headers: {
      HttpHeaders.authorizationHeader:
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjExNjYwMzI3LCJpc19zdGFmZiI6dHJ1ZX0.AnatYsL31HqP-KCy01bGOwcu1nzay0-s97yIkjipQUQ"
    });

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Approve'),
                          content: Text(
                              'Kindly Accept or Decline application to proceed'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Accept'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CreatedPg();
                                    },
                                  ),
                                );
                              },
                            ),
                            FlatButton(
                              child: Text('Decline'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CreatedPg();
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        ));
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data[index]['student'],
                            style: TextStyle(fontSize: 15)),
                        Text(data[index]['mobile'],
                            style: TextStyle(fontSize: 15)),
                        Text(data[index]['country'],
                            style: TextStyle(fontSize: 15)),
                        Text(data[index]['city'], style: TextStyle(fontSize: 15)),
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
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Text(data[index]['sponsorship_name'],
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
      )
    );
  }
}
