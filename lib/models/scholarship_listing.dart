class Sponsorships {
  String name;
  String description;
  int pk;

  Sponsorships(this.name, this.description, this.pk);

  Sponsorships.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }
}
