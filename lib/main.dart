import 'package:adrian_kenya/ui/staff/applications.dart';
import 'package:adrian_kenya/ui/staff/created.dart';
import 'package:adrian_kenya/ui/staff/newScholarship.dart';
import 'package:adrian_kenya/ui/staff/staffHome.dart';
import 'package:adrian_kenya/ui/student/availableScholarship.dart';
import 'package:adrian_kenya/ui/student/form.dart';
import 'package:adrian_kenya/ui/student/home.dart';
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
        SIGN_IN: (BuildContext context) => LoginScreen(),
        SIGN_UP: (BuildContext context) => SignUpScreen(),

        //student
        HOME: (BuildContext context) => HomePage(),
        FORM: (BuildContext context) => FormPg(),
        AVAILABLE: (BuildContext context) => AvailableScholarship(),

        //staff
        STAFFHOME: (BuildContext context) => StaffHomePg(),
        NEWSCHOLARSHIP: (BuildContext context) => NewScholarshipPg(),
        APPLICATIONS: (BuildContext context) => ApplicationsPg(),
        CREATED: (BuildContext context) =>CreatedPg(),
      },
      initialRoute: SIGN_IN,

    );
  }
}
