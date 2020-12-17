import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(),
      body: ApplicationsPg(),
    );
  }
}

class ApplicationsPg extends StatefulWidget {
  @override
  _ApplicationsPgState createState() => _ApplicationsPgState();
}

class _ApplicationsPgState extends State<ApplicationsPg> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}