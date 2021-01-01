import 'dart:convert';

LoginModel LoginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String LoginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.email,
    this.token,
  });

  String email;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "token": token,
  };
}