import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gmailapp/Home/ComposeEmailScreen.dart';
import 'package:gmailapp/Home/ViewMail.dart';
import 'package:gmailapp/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GmailHomePage extends StatefulWidget {
  final String email;
  final String password;

  const GmailHomePage({Key? key, required this.email, required this.password,}) : super(key: key);

  @override
  State<GmailHomePage> createState() => _GmailHomePageState();
}

class _GmailHomePageState extends State<GmailHomePage> {
  List<dynamic> emails = [];
  List<dynamic> filteredEmails = []; // List to hold filtered emails
  bool isLoading = true;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController(); // Controller for the search field

  @override
  void initState() {
    super.initState();
    fetchEmails();

    // Add listener for search field changes
    searchController.addListener(() {
      filterEmails();
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  // Fetch emails from the server
  Future<void> fetchEmails() async {
    final String email = widget.email;
    final String mailPassword = Uri.encodeComponent(widget.password);
    final String folderType = 'inbox';
    final int pageNumber = 1;

    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.111:4000/api/app/get-all-email?email=$email&mailPassword=$mailPassword&folderType=$folderType&pageNumber=$pageNumber'),
      );

      final data = json.decode(response.body);
      if (data['status'] == true) {
        setState(() {
          emails = data['response']['emails'];
          filteredEmails = emails; // Initially show all emails
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Error: ${data['message']}';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $error';
      });
    }
  }

  // Filter emails based on the search query
  void filterEmails() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredEmails = emails.where((email) {
        final subject = email['headers']['subject']?.toLowerCase() ?? '';
        final from = email['headers']['from']?.toLowerCase() ?? '';
        return subject.contains(query) || from.contains(query);
      }).toList();
    });
  }

  // Format email date
  String formatDate(String dateString) {
    try {
      final DateFormat inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z");
      DateTime dateTime = inputFormat.parse(dateString.split(' (')[0]);
      return DateFormat('d MMM').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.grey.shade800),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 2),
                  child: TextField(
                    controller: searchController, // Attach the controller to the search field
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Search in email',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              CircleAvatar(
                maxRadius: 16,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ), // User's profile picture
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
      drawer: GmailDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Primary",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
            errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : ListView.builder(
              itemCount: filteredEmails.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final email = filteredEmails[index];
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComposeEmailScreen(),
            ),
          );
          // Compose new email
        },
        icon: Icon(Icons.edit_outlined),
        label: Text("Compose"),
        backgroundColor: Colors.blue.shade50,
      ),
    );
  }
}
