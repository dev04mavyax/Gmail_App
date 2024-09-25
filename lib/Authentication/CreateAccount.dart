// import 'package:flutter/material.dart';
// import 'package:gmailapp/HomePage.dart';
//
//
//
// class CreateAccountScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 40),
//             Text(
//               'Google',
//               style: TextStyle(
//                 fontFamily: 'Roboto',
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Create a Google Account',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Enter your name',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 40),
//             Container(
//               height: 55,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(2),
//                   border: Border.all(color: Colors.grey.shade200)
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       hintText: 'First name',
//                       hintStyle: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontWeight: FontWeight.w400
//                       ),
//                       border:InputBorder.none
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               height: 55,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(2),
//                   border: Border.all(color: Colors.grey.shade200)
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       hintText: 'Surname (optional)',
//                       hintStyle: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontWeight: FontWeight.w400
//                       ),
//                       border:InputBorder.none
//                   ),
//                 ),
//               ),
//             ),
//             Spacer(),
//             Row(mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   width: 110,
//                   height: 50,
//                   child: ElevatedButton(
//
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
//
//                       // Handle Next button action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)
//                       ),
//                       minimumSize: Size(double.infinity, 50), // Full-width button
//                     ),
//                     child: Text('Next',style: TextStyle(
//                         color: Colors.white
//                     ),),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
