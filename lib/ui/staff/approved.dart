import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

class Approved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(),
      body: ApprovedPg(),
    );
  }
}

class ApprovedPg extends StatefulWidget {
  @override
  _ApprovedPgState createState() => _ApprovedPgState();
}

class _ApprovedPgState extends State<ApprovedPg> {
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
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.black),
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(
                'Hello',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text('Deadline on 30/12/2020'),
            );
          },
          itemCount: 30,
        ),
      ),
    );
  }
}