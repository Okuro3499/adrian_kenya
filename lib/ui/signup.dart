import 'package:adrian_kenya/api/api_service.dart';
import 'package:adrian_kenya/models/SignUpModel.dart';
import 'package:adrian_kenya/ui/login_screen.dart';
import 'package:adrian_kenya/utils/validator.dart';
import 'package:adrian_kenya/widgets/custom_shape.dart';
import 'package:adrian_kenya/widgets/customappbar.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Validator {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  bool isHidden = true;
  bool _isLoading = false;

  void _toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  showdialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("Creating Account..."),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                ],
              ));
        });
  }

  SignUpModel _user;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            userNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget userNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        controller: usernameController,
        keyboardType: TextInputType.name,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.blue[900], size: 20),
          hintText: "Username",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateName,
        onSaved: (String value) {
          usernameController.text = value;
        },
      ),
    );
  }

  Widget emailTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.blue[900], size: 20),
          hintText: "Email ID",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validateEmail,
        onSaved: (String value) {
          emailController.text = value;
        },
      ),
    );
  }

  Widget passwordTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isHidden,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.blue[900], size: 20),
          hintText: "Password",
          suffixIcon: IconButton(onPressed: _toggleVisibility, icon: isHidden ? Icon(Icons.visibility_off, color: Colors.blue[900], size: 20) : Icon(Icons.visibility, color: Colors.blue[900], size: 20)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        validator: validatePasswordLength,
        onSaved: (String value) {
          passwordController.text = value;
        },
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        if (!formKey.currentState.validate()) {
          return;
        }
        formKey.currentState.save();

        setState(() {
          _isLoading = true;
        });

        showdialog(context);

        final String username = usernameController.text;
        final String email = emailController.text;
        final String password = passwordController.text;

        final SignUpModel user = await createUser(email, password, username);

        setState(() {
          _user = user;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()),
                (Route<dynamic> route) => false);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return LoginScreen();
        //     },
        //   ),
        // );
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[900], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[900],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
