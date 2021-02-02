import 'package:flutter/material.dart';

import 'created.dart';


class DeleteScholarship extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This provides the total height & width of screen
    return AlertDialog(
      content: Text('Are you sure you want to delete this note?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CreatedPg();
                },
              ),
            );
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
