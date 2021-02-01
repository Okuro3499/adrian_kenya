import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/ui/staff/staffHome.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../login_screen.dart';
import 'deleteScholarship.dart';
import 'newScholarship.dart';

class CreatedPg extends StatefulWidget {
  @override
  _CreatedPgState createState() => _CreatedPgState();
}

class _CreatedPgState extends State<CreatedPg> {
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
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjEyMzM5MDA0LCJpc19zdGFmZiI6dHJ1ZX0.DDgPOW2_UKeQaka645jz5vaz47-FUiztNoPACZNwSqs"
      },
    );

    if (!mounted) {
      return null;
    }

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
          return StaffHomePage();
        },
      ),
    ));
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

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Created Scholarships"),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: null,
                  accountName: null,
                ),
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
          body: Container(
            height: _height,
            width: _width,
            child: ListView.builder(
              itemBuilder: (context, int index) {
                return Dismissible(
                  key: ValueKey(data[index]['pk']),
                  direction: DismissDirection.startToEnd,
                  // background: Container(
                  //   color: Colors.red,
                  //   padding: EdgeInsets.all(16),
                  //   child: Align(
                  //       child: Icon(Icons.delete, color: Colors.white),
                  //       alignment: Alignment.centerLeft),
                  // ),
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => DeleteScholarship());

                    if (result == true){
                     final deleteResult = await deleteScholarship(data[index]['pk']);

                     if(deleteResult !=null){
                       print('deleted successfuly');
                     } else{
                       print('not deleted successfuly');
                     }
                    }
                    print(result);
                    return result;
                  },
                  child: Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => NewScholarshipPg(
                                scholarship_id: data[index]['pk'])));
                        print (data[index]['pk']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index]['name'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data[index]['description'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
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
