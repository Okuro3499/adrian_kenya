import 'dart:convert';

import 'package:adrian_kenya/models/login_model.dart';
import 'package:adrian_kenya/ui/staff/staffHome.dart';
import 'package:adrian_kenya/ui/student/home.dart';
import 'package:adrian_kenya/widgets/custom_shape.dart';
import 'package:adrian_kenya/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adrian_kenya/utils/validator.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validator {
  bool isHidden = true;
  bool _isLoading = false;
  showdialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
            children: <Widget>[
              Text("Logging in..."),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            ],
          ));
        });
  }

  void _toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  signIn(String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    showdialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password": password};
    var jsonResponse;
    var res = await http.post("https://geoproserver.herokuapp.com/api/login/",
        body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      // Navigator.of(context).pushNamed("Home");
    }
    if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      sharedPreferences.setString("token", jsonResponse['token']);
      String token = jsonResponse['token'];
      /* decode() method will decode your token's payload */
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      if (decodedToken["is_staff"] != true) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => StaffHomePage()),
            (Route<dynamic> route) => false);
        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => StaffHomePage()));
      }
    }
  }

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  LoginModel _logUser;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                clipShape(),
                welcomeTextRow(),
                signInTextRow(),
                form(),
                SizedBox(height: _height / 12),
                button(),
                signUpTextRow(),
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
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
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
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          child: Image.asset(
            'assets/logo-adrian.png',
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
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
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isHidden,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.blue[900], size: 20),
          hintText: "Password",
          suffixIcon: IconButton(
              onPressed: _toggleVisibility,
              icon: isHidden
                  ? Icon(Icons.visibility_off,
                      color: Colors.blue[900], size: 20)
                  : Icon(Icons.visibility, color: Colors.blue[900], size: 20)),
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
      onPressed: () {
        if (!formKey.currentState.validate()) {
          return;
        }
        formKey.currentState.save();
        setState(() {
          _isLoading = true;
        });
        signIn(emailController.text, passwordController.text);
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
        child: Text('SIGN IN',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[900],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
}
