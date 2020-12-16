import 'package:adrian_kenya/ui/home.dart';
import 'package:adrian_kenya/ui/login_screen.dart';
import 'package:adrian_kenya/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Adrian",
      theme: ThemeData(primaryColor: mPrimaryColor),
      routes: <String, WidgetBuilder>{
        SIGN_IN: (BuildContext context) =>  LoginPage(),
        SIGN_UP: (BuildContext context) =>  SignUpScreen(),
        HOME: (BuildContext context) =>  HomePage(),
      },
      initialRoute: SIGN_IN,
    );
  }
}
