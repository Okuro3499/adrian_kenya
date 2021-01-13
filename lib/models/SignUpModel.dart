import 'dart:convert';

SignUpModel SignUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String SignUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.email,
    this.token,
    this.username,
  });

  String email;
  String token;
  String username;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        email: json["email"],
        token: json["token"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
        "username": username,
      };
}
