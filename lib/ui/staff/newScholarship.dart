import 'dart:convert';

import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/models/create_model.dart';
import 'package:adrian_kenya/models/update_model.dart';
import 'package:adrian_kenya/utils/validator.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../login_screen.dart';
import 'created.dart';

class Scholarship {
  final String name;
  final String description;

  Scholarship({this.name, this.description});

  factory Scholarship.fromJson(Map<String, dynamic> json) {
    return Scholarship(
      name: json['name'],
      description: json['description'],
    );
  }
}

class NewScholarshipPg extends StatefulWidget {
  int scholarship_id;
  NewScholarshipPg({Key key, this.scholarship_id}) : super(key: key);

  @override
  _NewScholarshipPgState createState() => _NewScholarshipPgState();
}

class _NewScholarshipPgState extends State<NewScholarshipPg> with Validator {
  int scholarship_id;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool _isLoading = false;
  bool get isEditing => scholarship_id != null;

  showdialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text(isEditing ? 'updating' : 'creating'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                ],
              ));
        });
  }

  CreateModel _scholarship;
  UpdateModel _update;

  TextEditingController scholarshipNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  Future<Scholarship> _futureScholarship;

  void initState() {
    super.initState();
    scholarship_id = widget.scholarship_id;
    _futureScholarship = fetchScholarship(scholarship_id);
  }

  Future<Scholarship> fetchScholarship(int scholarship_id) async {
    final response =
    await http.get('https://geoproserver.herokuapp.com/api/sponsorship/$scholarship_id/');

    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Scholarship.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Scholarship');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        appBar: AppBar(
            title: Text(isEditing ? 'Edit Scholarship' : 'New Scholarship')),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
              ),
              ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                            (Route<dynamic> route) => false);
                  })
            ],
          ),
        ),
        body: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height / 10),
                createTextRow(),
                applicationForm(),
                SizedBox(height: _height / 20),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            widget.scholarship_id == null ? 'New Scholarship' : 'Edit Scholarship',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget applicationForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: globalFormKey,
        child: Column(
          children: <Widget>[
            scholarshipNameTextFormField(),
            SizedBox(height: _height / 40.0),
            descriptionTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget scholarshipNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: scholarshipNameController,
        keyboardType: TextInputType.name,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.title, color: Colors.blue[900], size: 20),
          hintText: 'Scholarship Title',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateTitle,
        onSaved: (String value) {
          scholarshipNameController.text = value;
        },
      ),
    );
  }

  Widget descriptionTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: descriptionController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description_outlined,
              color: Colors.blue[900], size: 20),
          hintText: "Scholarship Details",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateDescription,
        onSaved: (String value) {
          descriptionController.text = value;
        },
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        showdialog(context);

        if (isEditing) {
          if (!globalFormKey.currentState.validate()) {
            return;
          }
          globalFormKey.currentState.save();

            final String name = scholarshipNameController.text;
            final String description = descriptionController.text;

          final UpdateModel update =
          await updateScholarship(widget.scholarship_id, name, description);

            setState(() {
              _update = update;
            });

          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                // title: Text('SUCCESS'),
                content: Text('Scholarship was edited successfully'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreatedPg();
                          },
                        ),
                      );
                    },
                  )
                ],
              ));
        } else {
          if (!globalFormKey.currentState.validate()) {
            return;
          }
          globalFormKey.currentState.save();

          final String name = scholarshipNameController.text;
          final String description = descriptionController.text;

          final CreateModel scholarship =
          await createScholarship(name, description);

          setState(() {
            _scholarship = scholarship;
          });


          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('SUCCESS'),
                content: Text('Scholarship was created successfully'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreatedPg();
                          },
                        ),
                      );
                    },
                  )
                ],
              ));
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[900], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          widget.scholarship_id == null ? 'Create' : 'Edit',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }
}
