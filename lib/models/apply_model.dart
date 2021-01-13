import 'dart:convert';

ApplyModel applyModelFromJson(String str) =>
    ApplyModel.fromJson(json.decode(str));

String applyModelToJson(ApplyModel data) => json.encode(data.toJson());

class ApplyModel {
  ApplyModel(
      {this.first_name,
      this.last_name,
      this.mobile,
      this.country,
      this.city,
      this.school_name,
      this.degree,
      this.cover_letter,
      this.postal_code});

  String first_name;
  String last_name;
  String mobile;
  String country;
  String city;
  String school_name;
  String degree;
  String cover_letter;
  String postal_code;

  factory ApplyModel.fromJson(Map<String, dynamic> json) => ApplyModel(
        first_name: json["first_name"],
        last_name: json["last_name"],
        mobile: json["mobile"],
        country: json["country"],
        city: json["city"],
        school_name: json["school_name"],
        degree: json["degree"],
        cover_letter: json["cover_letter"],
        postal_code: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "last_name": last_name,
        "mobile": mobile,
        "country": country,
        "city": city,
        "school_name": school_name,
        "degree": degree,
        "cover_letter": cover_letter,
        "postal_code": postal_code,
      };
}
