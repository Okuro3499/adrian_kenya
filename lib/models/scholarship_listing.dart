class ScholarshipListing {
  String scholarshipID;
  String scholarshipTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  ScholarshipListing(
      {
        this.scholarshipID,
        this.scholarshipTitle,
        this.createDateTime,
        this.latestEditDateTime
      }
      );
}