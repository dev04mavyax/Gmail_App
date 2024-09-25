import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gmailapp/widgets/EmailSend.dart';
import 'package:http/http.dart' as http;





class ComposeEmailScreen extends StatefulWidget {
  @override
  State<ComposeEmailScreen> createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  final TextEditingController toController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  List<File> attachments = [];

  // Function to pick files for attachment
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        attachments = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  // Function to send email to the backend API
  Future<void> _sendEmail() async {
    final url = Uri.parse('http://192.168.0.111:4000/api/app/send-mail')
        .replace(queryParameters: {
      'email': 'your-email@gmail.com', // Replace this with your actual email
      'mailPassword': 'your-password'  // Replace this with your actual password
    });

    var request = http.MultipartRequest('POST', url);

    // Add email details to the fields
    request.fields['recipientMail'] = toController.text;
    request.fields['cc'] = ccController.text;
    request.fields['subject'] = subjectController.text;
    request.fields['body'] = bodyController.text;

    // Add attachments
    for (var file in attachments) {
      request.files.add(await http.MultipartFile.fromPath(
        'attachments',
        file.path,
      ));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print('Email sent successfully');
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailSuccessScreen(
              to: toController.text,
              cc: ccController.text,
              subject: subjectController.text,
              body: bodyController.text,
            ),
          ),
        );
        // Navigator.pop(context);
        // _showDialog('Success', 'Email sent successfully');
      } else {
        print('Failed to send email');
        _showDialog('Error', 'Failed to send email');
      }
    } catch (e) {
      print('Error: $e');
      _showDialog('Error', 'An error occurred. Please try again.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.black),
            onPressed: () {
               _pickFiles();
            },
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () {
              _sendEmail();
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('Option 1')),
              PopupMenuItem(child: Text('Option 2')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("To",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,bottom: 0),
                        child: TextField(
                          controller: toController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.keyboard_arrow_down),
                            // labelText: 'Form',
                            hintText: "hariommishra95@gmail.com",
                            hintStyle: TextStyle(
                                fontSize: 15,fontWeight: FontWeight.w400
                            ),
                            labelStyle: TextStyle(fontSize: 18),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text("CC",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: ccController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          // labelText: 'Form',
                          labelStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Subject",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller:subjectController,
                        decoration: InputDecoration(
                          // suffixIcon: Icon(Icons.keyboard_arrow_down),
                          // labelText: 'Form',
                          labelStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Text("Compose email",style: TextStyle(
                //     fontWeight: FontWeight.w500,
                //     fontSize: 15
                // ),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      height: 48,
                      child: TextField(
                        controller: bodyController,
                        decoration: InputDecoration(
                          // suffixIcon: Icon(Icons.keyboard_arrow_down),
                          // labelText: 'Form',
                            labelStyle: TextStyle(fontSize: 18),
                            border: InputBorder.none,
                            hintText: "Compose email",
                            hintStyle:  TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Spacer(),
            Text("Attachments:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            SizedBox(height: 8),
            for (var file in attachments)
              Text(file.path.split('/').last),
          ],
        ),
      ),
    );
  }
}

// class ComposeEmailScreen extends StatefulWidget {
//   @override
//   _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
// }
//
// class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
//   final TextEditingController toController = TextEditingController();
//   final TextEditingController ccController = TextEditingController();
//   final TextEditingController subjectController = TextEditingController();
//   final TextEditingController bodyController = TextEditingController();
//   List<File> attachments = [];
//
//   // Function to pick files for attachment
//   Future<void> _pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'jpg', 'png'],
//     );
//
//     if (result != null) {
//       setState(() {
//         attachments = result.paths.map((path) => File(path!)).toList();
//       });
//     }
//   }
//
//   // Function to send email to the backend API
//   Future<void> _sendEmail() async {
//     final url = Uri.parse('http://192.168.0.111:4000/api/app/send-mail')
//         .replace(queryParameters: {
//       'email': 'your-email@gmail.com', // Replace this with your actual email
//       'mailPassword': 'your-password'  // Replace this with your actual password
//     });
//
//     var request = http.MultipartRequest('POST', url);
//
//     // Add email details to the fields
//     request.fields['recipientMail'] = toController.text;
//     request.fields['cc'] = ccController.text;
//     request.fields['subject'] = subjectController.text;
//     request.fields['body'] = bodyController.text;
//
//     // Add attachments
//     for (var file in attachments) {
//       request.files.add(await http.MultipartFile.fromPath(
//         'attachments',
//         file.path,
//       ));
//     }
//
//     try {
//       var response = await request.send();
//       if (response.statusCode == 201) {
//         print('Email sent successfully');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => EmailSuccessScreen(
//               to: toController.text,
//               cc: ccController.text,
//               subject: subjectController.text,
//               body: bodyController.text,
//             ),
//           ),
//         );
//         // _showDialog('Success', 'Email sent successfully');
//       } else {
//         print('Failed to send email');
//         _showDialog('Error', 'Failed to send email');
//       }
//     } catch (e) {
//       print('Error: $e');
//       _showDialog('Error', 'An error occurred. Please try again.');
//     }
//   }
//
//   void _showDialog(String title, String content) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.attach_file, color: Colors.black),
//             onPressed: _pickFiles,
//           ),
//           IconButton(
//             icon: Icon(Icons.send, color: Colors.black),
//             onPressed: _sendEmail,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("To", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
//               TextField(
//                 controller: toController,
//                 decoration: InputDecoration(
//                   hintText: "Recipient email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text("CC", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
//               TextField(
//                 controller: ccController,
//                 decoration: InputDecoration(
//                   hintText: "CC email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text("Subject", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
//               TextField(
//                 controller: subjectController,
//                 decoration: InputDecoration(
//                   hintText: "Subject",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text("Body", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
//               TextField(
//                 controller: bodyController,
//                 maxLines: 6,
//                 decoration: InputDecoration(
//                   hintText: "Compose email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               if (attachments.isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Attachments:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
//                     SizedBox(height: 8),
//                     for (var file in attachments)
//                       Text(file.path.split('/').last),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
