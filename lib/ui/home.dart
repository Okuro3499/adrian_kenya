// import 'package:flutter/material.dart';
//
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size; //This provides the total height & width of screen
//     return Scaffold(
//       body: Home(
//       ),
//     );
//   }
// }
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   List<String> Items = [
//     item(text: 'View available Scholarships'),
//     Item(text: 'View Scholarships'),
//     Item(text: 'View my Scholarships')
//   ];
//
//   Widget itemTemplate(item) {
//     return Card(
//       margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch ,
//           children: <Widget>[
//             Text(
//                 item.text,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.blue[900],
//             )
//             )
//             // SizedBox(height: 6.0),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('Homepage'),
//           centerTitle: true,
//       ),
//       body: Column(
//         children: Items.map((item) =>  itemTemplate(item)).toList(),
//       ),
//     );
//   }
// }
