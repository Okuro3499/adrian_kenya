import 'package:adrian_kenya/models/scholarship_listing.dart';


class ScholarshipService {
  List<ScholarshipListing> getScholarshipList() {
    return [
      new ScholarshipListing(
          scholarshipID: '1',
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now(),
          scholarshipTitle: 'UK Embassy Scholarship'
      ),
      new ScholarshipListing(
          scholarshipID: '2',
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now(),
          scholarshipTitle: 'Adrian Foundation'
      ),
      new ScholarshipListing(
          scholarshipID: '3',
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now(),
          scholarshipTitle: 'United Nations Program'
      )
    ];
  }
}