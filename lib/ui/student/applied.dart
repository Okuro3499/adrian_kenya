import 'package:flutter/material.dart';

class Applied extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(),
      body: AppliedPg(),
    );
  }
}

class AppliedPg extends StatefulWidget {
  @override
  _AppliedPgState createState() => _AppliedPgState();
}

class _AppliedPgState extends State<AppliedPg> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}