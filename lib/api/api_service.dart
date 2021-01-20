import 'dart:io';

import 'package:adrian_kenya/models/SignUpModel.dart';
import 'package:adrian_kenya/models/apply_model.dart';
import 'package:adrian_kenya/models/create_model.dart';
import 'package:adrian_kenya/models/login_model.dart';
import 'package:http/http.dart';

Future<SignUpModel> createUser(String email, String password, String username) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/register/";

  final response = await post(apiUrl,
      body: {"email": email, "password": password, "username": username});
  if (response.statusCode == 201) {
    final String responseString = response.body;

    return SignUpModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<LoginModel> loginUser(String email, String password) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/login/";

  final response = await post(apiUrl,
      body: {"email": email, "password": password});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return loginModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<CreateModel> createScholarship(String name, String description) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/sponsorship/";

  final response = await post(apiUrl, headers: {
    HttpHeaders.authorizationHeader:
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjExNjYwMzI3LCJpc19zdGFmZiI6dHJ1ZX0.AnatYsL31HqP-KCy01bGOwcu1nzay0-s97yIkjipQUQ"
  }, body: {
    "name": name,
    "description": description
  });
  if (response.statusCode == 201) {
    final String responseString = response.body;

    return createModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<ApplyModel> applyScholarship(
    int scholarship_id,
    String first_name,
    String last_name,
    String mobile,
    String country,
    String city,
    String school_name,
    String degree,
    String cover_letter,
    String postal_code) async {
  String apiUrl =
      "https://geoproserver.herokuapp.com/api/apply/$scholarship_id/";

  final response = await post(apiUrl, headers: {
    HttpHeaders.authorizationHeader:
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwidXNlcm5hbWUiOiJHaWRkaWUiLCJlbWFpbCI6ImdpZGVvbm9sbG9uZGVAZ21haWwuY29tIiwiZXhwIjoxNjExNjYwMjI0LCJpc19zdGFmZiI6ZmFsc2V9.Jz8Lz6C9OWGbsWPJOOcRTcnw7xIm0_-w4j7Oj-k96wM"
  }, body: {
    //personal
    "first_name": first_name,
    "last_name": last_name,
    "mobile": mobile,
    "country": country,
    "city": city,

    //education
    "school_name": school_name,
    "degree": degree,
    "cover_letter": cover_letter,
    "postal_code": postal_code,
  });
  if (response.statusCode == 201) {
    final String responseString = response.body;

    return applyModelFromJson(responseString);
  } else {
    return null;
  }
}
