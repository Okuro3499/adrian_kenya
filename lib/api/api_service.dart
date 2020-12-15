import 'package:adrian_kenya/models/login_model.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';


class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = 'https://geoproserver.herokuapp.com/api/login';

    final response = await http.post(url, body: requestModel.toJson());
    if(response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }

  }
}