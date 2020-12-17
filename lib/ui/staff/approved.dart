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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}