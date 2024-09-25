
import 'package:flutter/material.dart';
import 'dart:convert';  // For JSON decoding
import 'package:http/http.dart' as http;  // For HTTP requests
import 'package:gmailapp/Home/ViewMail.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailListPage extends StatefulWidget {
  final String email;
  final String password;

  const EmailListPage({Key? key, required this.email, required this.password,}) : super(key: key);

  @override
  _EmailListPageState createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  List<dynamic> emails = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEmails();
  }

  Future<void> fetchEmails() async {
    final prefs = await SharedPreferences.getInstance();

    final String email = widget.email; // Use the email from the widget
    final String mailPassword = widget.password; // Use the password from the widget

    // Encode the mailPassword to handle special characters
    final String encodedMailPassword = Uri.encodeComponent(mailPassword);

    final String folderType = 'inbox'; // Specify folder type
    final int pageNumber = 1; // Specify page number if needed

    print("Encoded password: $encodedMailPassword"); // Check the encoded password

    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.0.111:4000/api/app/get-all-email?email=$email&mailPassword=$encodedMailPassword&folderType=$folderType&pageNumber=$pageNumber'),
      );

      // Assuming a 200 response means the API endpoint was hit, we parse the JSON.
      final data = json.decode(response.body);
      print("Full data response: $data"); // Log the response data for debugging

      if (data['status'] == true) {
        setState(() {
          emails = data['response']['emails']; // Correctly access nested emails
          isLoading = false;
        });
      } else {
        print("Error in response: ${data['message']}"); // Log any message in the response
        setState(() {
          isLoading = false;
          errorMessage = 'Error: ${data['message']}'; // Display the message from the response
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $error';
      });
    }
  }
  String formatDate(String dateString) {
    try {
      print("Parsing date: $dateString"); // Print the date string being parsed
      // Use DateFormat to parse the date string
      final DateFormat inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z"); // Adjusting the format
      DateTime dateTime = inputFormat.parse(dateString.split(' (')[0]); // Remove timezone info
      return DateFormat('d MMM').format(dateTime); // Format to get day and month
    } catch (e) {
      print("Error parsing date: $e"); // Print any errors encountered
      return 'Invalid date'; // Handle any parsing errors
    }
  }



  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return
         errorMessage.isNotEmpty
        ? Center(child: Text(errorMessage))
        :
           ListView.builder(
             itemCount: emails.length,
             itemBuilder: (context, index) {
               final email = emails[index];
               return GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => ViewEmailScreen(
                         details: email['headers']['subject'] ?? 'Unknown Sender',
                         subject: email['headers']['from'] ?? 'Unknown Sender',
                         mail: email['headers']['to'] ?? 'Unknown Sender',
                         date: formatDate(email['headers']['date'] ?? ''),
                       ), // Pass the email to the ViewEmailScreen
                     ),
                   );
                 },
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                   child: Container(
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CircleAvatar(
                           child: Text((index + 1).toString()), // Display index number (starting from 1)
                         ),

                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   email['headers']['from'] ?? 'Unknown Sender',
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                                 SizedBox(height: 5),
                                 Text(email['headers']['subject'] ?? 'No Subject'), // Email preview
                               ],
                             ),
                           ),
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(formatDate(email['headers']['date'] ?? '')), // Replace with the actual date
                             SizedBox(height: 7),
                             Icon(Icons.star_border, size: 18),
                           ],
                         ),
                         SizedBox(width: 5),
                       ],
                     ),
                   ),
                 ),
               );
             },


         );
  }
}




// import 'package:flutter/material.dart';
// import 'dart:convert';  // For JSON decoding
// import 'package:http/http.dart' as http;  // For HTTP requests
// import 'package:gmailapp/Home/ViewMail.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class EmailList extends StatefulWidget {
//   @override
//   _EmailListState createState() => _EmailListState();
// }
//
// class _EmailListState extends State<EmailList> {
//   List<dynamic> emails = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchEmails();
//   }
//   List<dynamic> emailList = [];
//   Future<void> fetchEmails() async {
//     final url = 'http://192.168.0.111:4000/api/user/get-mail';
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('authToken');  // Retrieve the token if you stored it

//       if (token == null) {
//         print("No token found, please log in.");
//         return;
//       }
//
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',  // Pass the token for authentication
//           'Content-Type': 'application/json',
//         },
//       );
//
//       print('Response status: ${response.statusCode}');  // Log the status code
//       print('Response body: ${response.body}');          // Log the response body for debugging
//
//       if (response.statusCode == 200) { // Change to 200 if that's the success code for your backend
//         final responseBody = json.decode(response.body);
//         List<dynamic> emails = responseBody['response'];  // Ensure your backend sends emails in a 'response' field
//         print('Emails retrieved successfully: $emails');
//
//         // Process emails as needed, e.g., store them in a state variable for display
//         setState(() {
//           emailList = emails;  // Assuming emailList is a state variable
//           isLoading = false;   // Update loading state
//         });
//       } else {
//         print('Failed to load emails: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       physics: ScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: emails.length,
//       itemBuilder: (context, index) {
//         final email = emails[index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ViewEmailScreen(), // Pass the email data to the ViewEmailScreen
//               ),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//             child: Container(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     child: Text(email['sender'][0]),  // First letter of the sender's name
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             email['subject'],
//                             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//                           ),
//                           SizedBox(height: 5),
//                           Text(email['preview'] ?? 'No preview available'),  // Email preview
//                         ],
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(email['date']),  // Display the date from the email object
//                       SizedBox(height: 7),
//                       Icon(Icons.star_border, size: 18),
//                     ],
//                   ),
//                   SizedBox(width: 5),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// }

//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class EmailListPage extends StatefulWidget {
//   final String email;
//   final String password;
//
//   const EmailListPage({Key? key, required this.email, required this.password,}) : super(key: key);
//
//   @override
//   _EmailListPageState createState() => _EmailListPageState();
// }
//
// class _EmailListPageState extends State<EmailListPage> {
//   List<dynamic> emails = [];
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchEmails();
//   }
//
//   Future<void> fetchEmails() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final String email = widget.email; // Use the email from the widget
//     final String mailPassword = widget.password; // Use the password from the widget
//
//     // Encode the mailPassword to handle special characters
//     final String encodedMailPassword = Uri.encodeComponent(mailPassword);
//
//     final String folderType = 'inbox'; // Specify folder type
//     final int pageNumber = 1; // Specify page number if needed
//
//     print("Encoded password: $encodedMailPassword"); // Check the encoded password
//
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'http://192.168.0.111:4000/api/app/get-all-email?email=$email&mailPassword=$encodedMailPassword&folderType=$folderType&pageNumber=$pageNumber'),
//       );
//
//       // Assuming a 200 response means the API endpoint was hit, we parse the JSON.
//       final data = json.decode(response.body);
//       print("Full data response: $data"); // Log the response data for debugging
//
//       if (data['status'] == true) {
//         setState(() {
//           emails = data['response']['emails']; // Correctly access nested emails
//           isLoading = false;
//         });
//       } else {
//         print("Error in response: ${data['message']}"); // Log any message in the response
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Error: ${data['message']}'; // Display the message from the response
//         });
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error: $error';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage))
//           : ListView.builder(
//         itemCount: emails.length,
//         itemBuilder: (context, index) {
//           final email = emails[index];
//           return ListTile(
//             title: Text(email['headers']['subject'] ?? 'No Subject'), // Accessing subject correctly
//             subtitle: Text(email['headers']['from'] ?? 'Unknown Sender'), // Accessing sender correctly
//           );
//         },
//
//       ),
//     );
//   }
// }
