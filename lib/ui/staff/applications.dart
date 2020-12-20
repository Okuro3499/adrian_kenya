import 'package:adrian_kenya/api/scholarship_service.dart';
import 'package:adrian_kenya/models/scholarship_listing.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
  ScholarshipService get service => GetIt.I<ScholarshipService>();

  List<ScholarshipListing>scholarship =[];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    scholarship = service.getScholarshipList();
    super.initState();
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
            // return Dismissible(
            //   key: ValueKey(scholarship[index].scholarshipID),
            //   child:
              return ListTile(
                title: Text(
                  scholarship[index].scholarshipTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text('Deadline on ${formatDateTime(scholarship[index].createDateTime)}'),
              // ),
            );
          },
          itemCount: scholarship.length,
        ),
      ),
    );
  }
}