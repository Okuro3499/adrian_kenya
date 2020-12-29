import 'dart:convert';

ApplyModel applyModelFromJson(String str) => ApplyModel.fromJson(json.decode(str));

String applyModelToJson(ApplyModel data) => json.encode(data.toJson());

class ApplyModel{
  ApplyModel({
    this.name,
    this.mobile,
    this.country,
    this.city,
    this.schoolName,
    this.degree,
    this.coverLetter,
    this.level,
    this.schoolAddress,
    this.certificate,
    this.id,
  });

  String name;
  String mobile;
  String country;
  String city;
  String schoolName;
  String degree;
  String coverLetter;
  String level;
  String schoolAddress;
  String certificate;
  String id;

  factory ApplyModel.fromJson(Map<String, dynamic> json) => ApplyModel(
    name: json["first_name"],
    mobile: json["mobile"],
    country: json["country"],
    city: json["city"],
    schoolName: json["school_name"],
    degree: json["degree"],
    coverLetter: json["cover_letter"],
    level: json["to"],
    schoolAddress: json["postal_code"],
    certificate: json["birth_certificate"],
    id: json["national_id"],
  );

  Map<String, dynamic> toJson() => {
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
  };
}