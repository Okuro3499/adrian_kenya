import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/models/apply_model.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:adrian_kenya/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Form"
          ),
      ),
      body: FormPg(
      ),
    );
  }
}

class FormPg extends StatefulWidget {
  @override
  _FormPgState createState() => _FormPgState();
}

class _FormPgState extends State<FormPg> {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  ApplyModel _apply;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController cvController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  TextEditingController idController = TextEditingController();

  GlobalKey<FormState> globalForm1Key = new GlobalKey<FormState>();
  GlobalKey<FormState> globalForm2Key = new GlobalKey<FormState>();

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
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget personalForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: globalForm1Key,
        child: Column(
          children: <Widget>[
            nameTextFormField(),
            SizedBox(height: _height / 40.0),
            phoneTextFormField(),
            SizedBox(height: _height / 40.0),
            countryTextFormField(),
            SizedBox(height: _height / 40.0),
            cityTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget nameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: nameController,
      icon: Icons.person,
      hint: "Name",
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.phone,
      textEditingController: phoneController,
      icon: Icons.phone,
      hint: "Phone number",
    );
  }

  Widget countryTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: countryController,
      icon: Icons.add_location_alt_outlined ,
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


  Widget educationTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Education Information",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget educationForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: globalForm2Key,
        child: Column(
          children: <Widget>[
            schoolTextFormField(),
            SizedBox(height: _height / 40.0),
            levelTextFormField(),
            SizedBox(height: _height / 40.0),
            degreeTextFormField(),
            SizedBox(height: _height / 40.0),
            cvTextFormField(),
            SizedBox(height: _height / 40.0),
            schoolAddressTextFormField(),
            SizedBox(height: _height / 40.0),
            birthTextFormField(),
            SizedBox(height: _height / 40.0),
            idTextFormField(),

          ],
        ),
      ),
    );
  }

  Widget schoolTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.name,
      textEditingController: schoolNameController,
      icon: Icons.school_outlined ,
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
      textEditingController: cvController,
      icon: Icons.description,
      hint: "Cover Letter",
    );
  }

  Widget levelTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: levelController,
      icon: Icons.bar_chart_outlined ,
      hint: "Level of Education",
    );
  }

  Widget schoolAddressTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: schoolAddressController,
      icon: Icons.add_location_alt_outlined ,
      hint: "School address",
    );
  }

  Widget birthTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: certificateController,
      icon: Icons.local_hospital ,
      hint: "Birth Certificate No.",
    );
  }

  Widget idTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: idController,
      icon: Icons.perm_identity ,
      hint: "ID No.",
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async{
        final String name = nameController.text;
        final String mobile = phoneController.text;
        final String country = countryController.text;
        final String city = cityController.text;
        final String schoolName = schoolNameController.text;
        final String degree = degreeController.text;
        final String coverLetter = cvController.text;
        final String level = levelController.text;
        final String schoolAddress = schoolAddressController.text;
        final String certificate = certificateController.text;
        final String id = idController.text;

        final ApplyModel apply = await applyScholarship(name, mobile, country, city, schoolName, degree, coverLetter, level, schoolAddress, certificate, id);

        setState(() {
          _apply = apply;
        });
        print("application successful");
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width:_large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[900], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('APPLY', style: TextStyle(fontSize: _large? 14: (_medium? 12: 10)),),
      ),
    );
  }

}