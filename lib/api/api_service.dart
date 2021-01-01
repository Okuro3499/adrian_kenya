import 'dart:io';

import 'package:adrian_kenya/models/SignUpModel.dart';
import 'package:adrian_kenya/models/apply_model.dart';
import 'package:adrian_kenya/models/create_model.dart';
import 'package:adrian_kenya/models/login_model.dart';
import 'package:http/http.dart';

Future<SignUpModel> createUser(String email, String password, String username) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/register/";

  final response = await post(apiUrl, body: {
    "email": email,
    "password": password,
    "username": username
  });
  if(response.statusCode == 201) {
    final String responseString = response.body;

    return SignUpModelFromJson(responseString);
  } else{
    return null;
  }
}

Future<LoginModel> loginUser(String email, String password) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/login/";

  final response = await post(apiUrl, body: {
    "email": email,
    "password": password
  });
  if(response.statusCode == 201) {
    final String responseString = response.body;

    return LoginModelFromJson(responseString);
  } else{
    return null;
  }
}

Future<CreateModel> createScholarship(String name, String description) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/sponsorship/";

  final response = await post(apiUrl, headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjA5NzY2NzU4LCJpc19zdGFmZiI6dHJ1ZX0.e8QzJ4R04LHIWlwd4Qm8AQ5JhSP87Ezxc1_aGDFVj-o"}, body: {
    "name": name,
    "description": description
  });
  if(response.statusCode == 201) {
    final String responseString = response.body;

    return createModelFromJson(responseString);
  } else{
    return null;
  }
}

Future<ApplyModel> applyScholarship(String name, String mobile, String country, String city, String schoolName, String degree, String coverLetter, String level, String schoolAddress, String certificate, String id ) async {
  String apiUrl = "https://geoproserver.herokuapp.com/api/apply/{sponsorship_id}/";

  final response = await post(apiUrl, headers: {HttpHeaders.authorizationHeader: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwidXNlcm5hbWUiOiJHaWRkaWUiLCJlbWFpbCI6ImdpZGVvbm9sbG9uZGVAZ21haWwuY29tIiwiZXhwIjoxNjA5Nzc5ODY2LCJpc19zdGFmZiI6ZmFsc2V9._wV0kYuBz-pcr9v2hId9QaoS9ymE0Uq8QBuG9fMiRQ4"}, body: {
    "first_name": name,
    "mobile": mobile,
    "country": country,
    "city": city,
    "school_name": schoolName,
    "degree": degree,
    "cover_letter": coverLetter,
    "to": level,
    "postal_code": schoolAddress,
    "birth_certificate": certificate,
    "national_id": id,
  });
  if(response.statusCode == 201) {
    final String responseString = response.body;

    return applyModelFromJson(responseString);
  } else{
    return null;
  }
}

