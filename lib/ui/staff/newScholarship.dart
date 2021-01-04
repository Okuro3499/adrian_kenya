import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/models/create_model.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:adrian_kenya/widgets/textformfield.dart';
import 'package:flutter/material.dart';

import 'created.dart';

class NewScholarship extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text("New Scholarship"),
      ),
      body: NewScholarshipPg(),
    );
  }
}
class NewScholarshipPg extends StatefulWidget {
  @override
  _NewScholarshipPgState createState() => _NewScholarshipPgState();
}

class _NewScholarshipPgState extends State<NewScholarshipPg> {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  CreateModel _scholarship;

  TextEditingController scholarshipNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> globalForm3Key = new GlobalKey<FormState>();

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
    );
  }

  Widget createTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Create new Scholarship",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget applicationForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: globalForm3Key,
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

  Widget scholarshipNameTextFormField(){
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: scholarshipNameController,
      icon: Icons.title,
      hint: "Scholarship Title",
    );
  }

  Widget descriptionTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: descriptionController,
      icon: Icons.description_outlined,
      hint: "Scholarship Details",
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async{
        final String name = scholarshipNameController.text;
        final String description = descriptionController.text;

        final CreateModel scholarship = await createScholarship(name, description);

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
          )
        );
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width:_large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[900], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('CREATE', style: TextStyle(fontSize: _large? 14: (_medium? 12: 10)),),
      ),
    );
  }

}
