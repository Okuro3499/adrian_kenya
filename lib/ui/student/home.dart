import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

import 'availableScholarship.dart';
import 'form.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Student Home"
        ),
      ),
      body:Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        padding: EdgeInsets.only(bottom: 2),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height / 25),
              viewScholarshipCard(),
            ],
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
                return AvailableScholarship();
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

}