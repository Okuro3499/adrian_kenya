import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/models/apply_model.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:adrian_kenya/widgets/textformfield.dart';
import 'package:flutter/material.dart';

import 'availableScholarship.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: FormPg(),
    );
  }
}

class FormPg extends StatefulWidget {
  int scholarship_id;
  FormPg({
    Key key,
    this.scholarship_id,
  }) : super(key: key);
  @override
  _FormPgState createState() => _FormPgState();
}

class _FormPgState extends State<FormPg> {
  int scholarship_id;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  ApplyModel _apply;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController coverLetterController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  GlobalKey<FormState> globalForm1Key = new GlobalKey<FormState>();
  GlobalKey<FormState> globalForm2Key = new GlobalKey<FormState>();

  void initState() {
    super.initState();
    scholarship_id = widget.scholarship_id;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height / 10),
                personalTextRow(),
                personalForm(),
                SizedBox(height: _height / 20),
                educationTextRow(),
                educationForm(),
                SizedBox(height: _height / 20),
                button(),
              ],
            ),
          ),
        ),
      )

    );
  }

  Widget personalTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Personal Information",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  //personal
  Widget personalForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: globalForm1Key,
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 40.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 40.0),
            mobileTextFormField(),
            SizedBox(height: _height / 40.0),
            countryTextFormField(),
            SizedBox(height: _height / 40.0),
            cityTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: firstNameController,
      icon: Icons.person,
      hint: "First Name",
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: lastNameController,
      icon: Icons.person,
      hint: "Last Name",
    );
  }

  Widget mobileTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.phone,
      textEditingController: mobileController,
      icon: Icons.phone,
      hint: "Phone number",
    );
  }

  Widget countryTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: countryController,
      icon: Icons.add_location_alt_outlined,
      hint: "Country",
    );
  }

  Widget cityTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: cityController,
      icon: Icons.add_location_alt_outlined,
      hint: "City",
    );
  }

  //education
  Widget educationTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Education Information",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget educationForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: globalForm2Key,
        child: Column(
          children: <Widget>[
            schoolNameTextFormField(),
            SizedBox(height: _height / 40.0),
            degreeTextFormField(),
            SizedBox(height: _height / 40.0),
            cvTextFormField(),
            SizedBox(height: _height / 40.0),
            postalCodeTextFormField(),
            SizedBox(height: _height / 40.0),
          ],
        ),
      ),
    );
  }

  Widget schoolNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: schoolNameController,
      icon: Icons.school_outlined,
      hint: "Name of School",
    );
  }

  Widget degreeTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: degreeController,
      icon: Icons.school_outlined,
      hint: "Degree",
    );
  }

  Widget cvTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: coverLetterController,
      icon: Icons.description,
      hint: "Cover Letter",
    );
  }

  Widget postalCodeTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: postalCodeController,
      icon: Icons.add_location_alt_outlined,
      hint: "School address",
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        final String first_name = firstNameController.text;
        final String last_name = lastNameController.text;
        final String mobile = mobileController.text;
        final String country = countryController.text;
        final String city = cityController.text;
        final String school_name = schoolNameController.text;
        final String degree = degreeController.text;
        final String cover_letter = coverLetterController.text;
        final String postal_code = postalCodeController.text;

        final ApplyModel apply = await applyScholarship(widget.scholarship_id, first_name, last_name,
            mobile, country, city, school_name, degree, cover_letter, postal_code);

        setState(() {
          _apply = apply;
        });

        print(widget.scholarship_id);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('SUCCESS'),
            content: Text('Successfully applied for Scholarship'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AvailableScholarship();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        );
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
          'APPLY',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }
}
