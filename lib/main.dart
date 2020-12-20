import 'package:adrian_kenya/ui/staff/created.dart';
import 'package:adrian_kenya/ui/student/home.dart';
import 'package:adrian_kenya/ui/login_screen.dart';
import 'package:adrian_kenya/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'api/scholarship_service.dart';
import 'constants.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ScholarshipService());
}

void main() {
  setupLocator();
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
        SIGN_IN: (BuildContext context) => LoginPage(),
        SIGN_UP: (BuildContext context) => SignUpScreen(),
        HOME: (BuildContext context) => HomePage(),
        CREATE: (BuildContext context) =>CreatedPg()
      },
      initialRoute: SIGN_IN,
    );
  }
}
