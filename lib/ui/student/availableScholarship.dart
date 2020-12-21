import 'package:adrian_kenya/models/scholarship_listing.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  List<Sponsorships> _sponsorships = List<Sponsorships>();

  Future<List<Sponsorships>> fetchSponsorships() async {
    var apiUrl = 'https://geoproserver.herokuapp.com/api/sponsorship';
    var response = await http.get(apiUrl);

    var sponsorships = List<Sponsorships>();

    if(response.statusCode == 200) {
      var sponsorshipsJson = json.decode(response.body);
      for (var sponsorshipJson in sponsorshipsJson) {
        sponsorships.add(Sponsorships.fromJson(sponsorshipJson));
      }
    }
    return sponsorships;
  }

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
    fetchSponsorships().then((value) {
      setState(() {
        _sponsorships.addAll(value);
      });
    });

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
        child: ListView.builder(
          itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_sponsorships[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(_sponsorships[index].description,
                            style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
            );
          },
          itemCount: _sponsorships.length,
        ),
      ),
    );
  }
}