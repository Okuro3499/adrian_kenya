import 'package:adrian_kenya/models/scholarship_listing.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

class Created extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(),
      body: CreatedPg(),
    );
  }
}

class CreatedPg extends StatefulWidget {
  @override
  _CreatedPgState createState() => _CreatedPgState();
}

class _CreatedPgState extends State<CreatedPg> {
  final scholarship = [
    new ScholarshipListing(
        scholarshipID: '1',
        createDateTime: DateTime.now(),
        latestEditDateTime: DateTime.now(),
        scholarshipTitle: 'UK Embassy Scholarship'
    ),
    new ScholarshipListing(
        scholarshipID: '1',
        createDateTime: DateTime.now(),
        latestEditDateTime: DateTime.now(),
        scholarshipTitle: 'Adrian Foundation'
    ),
    new ScholarshipListing(
        scholarshipID: '1',
        createDateTime: DateTime.now(),
        latestEditDateTime: DateTime.now(),
        scholarshipTitle: 'United Nations Program'
    )
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
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
            return Dismissible(
              key: ValueKey(scholarship[index].scholarshipID),
              // direction: DismissDirection.startToEnd,
              // onDismissed: (direction) {
              // },
              // confirmDismiss: (direction) async {
              //   final result = await showDialog(
              //       context: context,
              //       builder: (_) => ScholarshipDelete()
              //   );
              //   print (result);
              //   return result;
              // },
              // background: Container(
              //   color: Colors.red,
              //   padding: EdgeInsets.only(left: 16),
              //   child: Align(
              //     child: Icon(
              //         Icons.delete,
              //         color: Colors.white
              //     ),
              //     alignment: Alignment.centerLeft,
              //   ),
              // ),
              child: ListTile(
                  title: Text(
                    scholarship[index].scholarshipTitle,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text('Deadline on ${formatDateTime(scholarship[index].createDateTime)}'),
                ),
            );
          },
          itemCount: scholarship.length,
        ),
      ),
    );
  }
}