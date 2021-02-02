import 'dart:convert';
import 'dart:io';

import 'package:adrian_kenya/models/SignUpModel.dart';
import 'package:adrian_kenya/models/apply_model.dart';
import 'package:adrian_kenya/models/create_model.dart';
import 'package:adrian_kenya/models/login_model.dart';
import 'package:adrian_kenya/models/update_model.dart';
import 'package:adrian_kenya/ui/staff/newScholarship.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

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
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjEyNzc4MjEwLCJpc19zdGFmZiI6dHJ1ZX0.S0o4edjGUrNPUf7DDBQ5TE24JOTbBKvOzjr3ArIvDTE"
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
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwidXNlcm5hbWUiOiJHaWRkaWUiLCJlbWFpbCI6ImdpZGVvbm9sbG9uZGVAZ21haWwuY29tIiwiZXhwIjoxNjEyMzM5MjA0LCJpc19zdGFmZiI6ZmFsc2V9.Vr9ZM9I7M6_iuhG04ztLERw1rw1ilQdThlN3piaI0mA"
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

Future<UpdateModel> updateScholarship(int scholarship_id, String name, String description) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/sponsorship/$scholarship_id/";

  final response = await put(apiUrl, headers: {
    HttpHeaders.authorizationHeader:
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjEyNzc4MjEwLCJpc19zdGFmZiI6dHJ1ZX0.S0o4edjGUrNPUf7DDBQ5TE24JOTbBKvOzjr3ArIvDTE"
  }, body: {
    "name": name,
    "description": description
  });
  if (response.statusCode == 200) {
    final String responseString = response.body;

    return updateModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<Scholarship> deleteScholarship(int scholarship_id) async {
  final http.Response response = await http.delete(
    'https://geoproserver.herokuapp.com/api/sponsorship/$scholarship_id/',
    headers: {
      HttpHeaders.authorizationHeader:
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjEyNzc4MjEwLCJpc19zdGFmZiI6dHJ1ZX0.S0o4edjGUrNPUf7DDBQ5TE24JOTbBKvOzjr3ArIvDTE"
    });

  if (response.statusCode == 204) {
    // If the server did return a 204 OK response,
    // then parse the JSON.
    if(response.body.isNotEmpty){
      json.decode(response.body);
    }

    return Scholarship.fromJson(json.decode(response.body));

  }
}
