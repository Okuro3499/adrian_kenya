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
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController levelController = TextEditingController();
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
            addressTextFormField(),
            SizedBox(height: _height / 40.0),
            phoneTextFormField(),
            SizedBox(height: _height / 40.0),
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            certTextRow(),
            SizedBox(height: _height / 40.0),
            idTextRow(),
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

  Widget addressTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.streetAddress,
      textEditingController: addressController,
      icon: Icons.add_location_alt_outlined ,
      hint: "address",
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

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.streetAddress,
      textEditingController: emailController,
      icon: Icons.email ,
      hint: "Email",
    );
  }

  Widget certTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.attach_file ),
          Text(
            "Upload birth certificate",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget idTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.attach_file ),
          Text(
            "Upload id photo",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
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
            address2TextFormField(),
            SizedBox(height: _height / 40.0),
            levelTextFormField(),
            SizedBox(height: _height / 40.0),
            yearTextFormField(),
            SizedBox(height: _height / 40.0),
            reasonTextRow(),
            SizedBox(height: _height / 40.0),
            recommendationTextRow(),
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

  Widget address2TextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: addressController,
      icon: Icons.add_location_alt_outlined ,
      hint: "School address",
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

  Widget yearTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.streetAddress,
      textEditingController: yearController,
      icon: Icons.calendar_today_outlined,
      hint: "Year of completion",
    );
  }

  Widget reasonTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Column(
        children: <Widget>[
          Icon(Icons.attach_file ),
          Text(
            "Upload file giving reason why you deserve scholarship" ,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget recommendationTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.attach_file ),
          Text(
            "Upload recommendation letter",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        Navigator.of(context).pop();
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