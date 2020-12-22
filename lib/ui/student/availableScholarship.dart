import 'package:adrian_kenya/models/scholarship_listing.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

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

  // List<Sponsorships> _sponsorships = List<Sponsorships>();

  Future<List<Sponsorships>> getSponsorships() async {
    var data = await http.get('https://geoproserver.herokuapp.com/api/sponsorship');
    var jsonData = json.decode(data.body);
    // var apiUrl = 'https://geoproserver.herokuapp.com/api/sponsorship';
    // var response = await http.get(apiUrl);
    // var sponsorships = List<Sponsorships>();
    // if(response.statusCode == 200) {
    //   var sponsorshipJson = json.decode(response.body);
    //   for (var sponsorshipJson in sponsorshipJson) {
    //     sponsorships.add(Sponsorships.fromJson(sponsorshipJson));
    //   }
    // }
    // return sponsorships;
    List<Sponsorships> _sponsorship = [];

    for (var u in jsonData) {
      Sponsorships sponsorships = Sponsorships(u['name'], u['description']);

     _sponsorship.add(sponsorships);
    }
    print(_sponsorship.length);
    return _sponsorship;
  }

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
    // fetchSponsorships().then((value) {
    //   setState(() {
    //     _sponsorships.addAll(value);
    //   });
    // });

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
        child: FutureBuilder(
          future: getSponsorships(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                  );
                },
              );
            }
          }
        ),
      ),
    );
  }
}