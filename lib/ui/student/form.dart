import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/models/apply_model.dart';
import 'package:adrian_kenya/ui/student/home.dart';
import 'package:adrian_kenya/utils/validator.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
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

class _FormPgState extends State<FormPg> with Validator {
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

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

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
                // SizedBox(height: _height / 20),
                // educationTextRow(),
                // educationForm(),
                SizedBox(height: _height / 20),
                button(),
              ],
            ),
          ),
        ),
      ),
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
        key: globalFormKey,
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
            SizedBox(height: _height / 40.0),
            educationTextRow(),
            SizedBox(height: _height / 40.0),
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

  Widget firstNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: firstNameController,
        keyboardType: TextInputType.name,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.blue[900], size: 20),
          hintText: "First Name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateName,
        onSaved: (String value) {
          firstNameController.text = value;
        },
      ),
    );
  }

  Widget lastNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: lastNameController,
        keyboardType: TextInputType.name,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.blue[900], size: 20),
          hintText: "Last Name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateName,
        onSaved: (String value) {
          lastNameController.text = value;
        },
      ),
    );
  }

  Widget mobileTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: mobileController,
        keyboardType: TextInputType.phone,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone, color: Colors.blue[900], size: 20),
          hintText: "Phone number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateMobile,
        onSaved: (String value) {
          mobileController.text = value;
        },
      ),
    );
  }

  Widget countryTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: countryController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_location_alt_outlined,
              color: Colors.blue[900], size: 20),
          hintText: "Country",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateCountry,
        onSaved: (String value) {
          countryController.text = value;
        },
      ),
    );
  }

  Widget cityTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: cityController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_location_alt_outlined,
              color: Colors.blue[900], size: 20),
          hintText: "City",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateCity,
        onSaved: (String value) {
          cityController.text = value;
        },
      ),
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

  // Widget educationForm() {
  //   return Container(
  //     margin: EdgeInsets.only(
  //         left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
  //     child: Form(
  //       key: globalFormKey,
  //       child: Column(
  //         children: <Widget>[
  //           schoolNameTextFormField(),
  //           SizedBox(height: _height / 40.0),
  //           degreeTextFormField(),
  //           SizedBox(height: _height / 40.0),
  //           cvTextFormField(),
  //           SizedBox(height: _height / 40.0),
  //           postalCodeTextFormField(),
  //           SizedBox(height: _height / 40.0),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget schoolNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: schoolNameController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.school_outlined, color: Colors.blue[900], size: 20),
          hintText: "Name of School",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateSchoolName,
        onSaved: (String value) {
          schoolNameController.text = value;
        },
      ),
    );
  }

  Widget degreeTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: degreeController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.school_outlined, color: Colors.blue[900], size: 20),
          hintText: "Degree",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateDegree,
        onSaved: (String value) {
          degreeController.text = value;
        },
      ),
    );
  }

  Widget cvTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: coverLetterController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.description, color: Colors.blue[900], size: 20),
          hintText: "CV",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateCv,
        onSaved: (String value) {
          coverLetterController.text = value;
        },
      ),
    );
  }

  Widget postalCodeTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: postalCodeController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_location_alt_outlined,
              color: Colors.blue[900], size: 20),
          hintText: "Postal Code",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validatePostal,
        onSaved: (String value) {
          postalCodeController.text = value;
        },
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        if (!globalFormKey.currentState.validate()) {
          return;
        }
        globalFormKey.currentState.save();

        final String first_name = firstNameController.text;
        final String last_name = lastNameController.text;
        final String mobile = mobileController.text;
        final String country = countryController.text;
        final String city = cityController.text;
        final String school_name = schoolNameController.text;
        final String degree = degreeController.text;
        final String cover_letter = coverLetterController.text;
        final String postal_code = postalCodeController.text;

        final ApplyModel apply = await applyScholarship(
            widget.scholarship_id,
            first_name,
            last_name,
            mobile,
            country,
            city,
            school_name,
            degree,
            cover_letter,
            postal_code);

        setState(() {
          _apply = apply;
        });

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('SUCCESS'),
              content: Text('Scholarship applied successfully'),
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
            )
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
