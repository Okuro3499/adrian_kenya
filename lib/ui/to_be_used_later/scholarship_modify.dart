import 'package:flutter/material.dart';

class ScholarshipModify extends StatelessWidget {

  final String scholarshipID;
  bool get isEditing =>scholarshipID != null;

  ScholarshipModify({this.scholarshipID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: 'Scholarship title'
              ),
            ),

            Container(height: 8),

            TextField(
              decoration: InputDecoration(
                  hintText: 'Scholarship Description'
              ),
            ),

            Container(height: 16),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  //   if (isEditing) {
                  //   // update note in api
                  // } else {
                  //   //create in api
                  // }
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}