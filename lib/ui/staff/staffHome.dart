import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import 'applications.dart';
import 'created.dart';
import 'newScholarship.dart';

class StaffHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Home"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
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
      body: StaffHomePg(),
    );
  }
}

class StaffHomePg extends StatefulWidget {
  @override
  _StaffHomePgState createState() => _StaffHomePgState();
}

class _StaffHomePgState extends State<StaffHomePg> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        // title: new Text('Are you sure?'),
        content: new Text('Do you want to Logout'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                    (Route<dynamic> route) => false),
            child: new Text('Yes'),
          ),
        ],
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
            padding: EdgeInsets.only(bottom: 2),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: _height / 25),
                  viewScholarshipCard(),
                  SizedBox(height: _height / 25),
                  applicationsCard(),
                  SizedBox(height: _height / 2.8),
                  button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewScholarshipCard() {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreatedPg();
              },
            ),
          );
        },
        child: Container(
          width: 300,
          height: 100,
          child: Center(
            child: Text(
              'View available Scholarships',
            ),
          ),
        ),
      ),
    );
  }

  Widget applicationsCard() {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ApplicationsPg();
              },
            ),
          );
        },
        child: Container(
          width: 300,
          height: 100,
          child: Center(child: Text('View all applications')),
        ),
      ),
    );
  }

  Widget button() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return NewScholarshipPg();
            },
          ),
        );
      },
    );
  }
}
