import 'package:adrian_kenya/models/SignUpModel.dart';
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
