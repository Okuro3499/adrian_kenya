import 'dart:convert';

UpdateModel updateModelFromJson(String str) =>
    UpdateModel.fromJson(json.decode(str));

String updateModelToJson(UpdateModel data) => json.encode(data.toJson());

class UpdateModel {
  UpdateModel({
    this.name,
    this.description,
  });

  String name;
  String description;

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {"name": name, "description": description};
}


// String scholarToJson(int scholarship_id, String name, String description) {
//   final jsonData = scholarToJson(scholarship_id, name, description);
//   return json.encode(jsonData);
// }
