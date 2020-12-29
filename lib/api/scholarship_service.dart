// import 'dart:convert';
//
// import 'package:adrian_kenya/models/scholarship_listing.dart';
// import 'package:http/http.dart' as http;
//
// import 'Api_response.dart';
//
// class ScholarshipService {
//
//   static const API = 'https://geoproserver.herokuapp.com';
//   static const headers = {
//     'apiKey' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJzdGFmZiIsImVtYWlsIjoiZ2Vvc3RhZmZAZ21haWwuY29tIiwiZXhwIjoxNjA5MDU4MzUyLCJpc19zdGFmZiI6dHJ1ZX0.zTD8jkj4QFHsEiTi0OnFSO2IeB9keksEbqFyozxDdpk'
//   };
//
//   Future<APIResponse<List<ScholarshipListing>>> getScholarshipList() {
//     return http.get(API + '/api/sponsorship', headers: headers)
//         .then((data){
//           if (data.statusCode == 200) {
//             final jsonData = json.decode(data.body);
//             final scholarship = <ScholarshipListing>[];
//             for (var item in jsonData) {
//               final scholarship = ScholarshipListing(
//                 name: item['name'],
//                 description: item['description'],
//                 pk: item['pk']
//               );
//
//               scholarship.toString();
//               // scholarship.add(scholarship);
//             }
//             return APIResponse<List<ScholarshipListing>>(data: scholarship);
//           }
//           return APIResponse<List<ScholarshipListing>>(
//               error: true,
//               errorMessage: 'An error occurred');
//     })
//     .catchError((_) => APIResponse<List<ScholarshipListing>>(
//         error: true,
//         errorMessage: 'An error occurred'));
//   }
// }