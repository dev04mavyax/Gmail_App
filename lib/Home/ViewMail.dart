import 'package:flutter/material.dart';



class ViewEmailScreen extends StatelessWidget {
  final String subject;
  final String details;
  final String mail;
  final String date;

  const ViewEmailScreen({Key? key, required this.subject, required this.details, required this.mail, required this.date,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.archive_outlined),
            onPressed: () {
              // Action for download
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              // Action for delete
            },
          ),
          IconButton(
            icon: Icon(Icons.email_outlined),
            onPressed: () {
              // Action for delete
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Use Expanded to take available space
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // height: 40, // Consider removing fixed height
                        child: Column(
                          children: [
                            Text(
                              subject,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, // Add this line
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Text(
                            'Inbox',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.star_border_outlined, size: 20),
              ],
            ),

            SizedBox(height: 20,),
            // Sender Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    'C',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mail,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${date} to me',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Title and Company Logo
            Center(
              child: Column(
                children: [
                  Text(
                    'ToXSL Technologies is hiring for Project Coordinator',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),

                ],
              ),
            ),
            SizedBox(height: 20),

            // Message Body
            Text(
              '${details}',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 10),


            // SizedBox(height: 320,),
            Spacer(),
            Row(
              children: [
                Icon(Icons.attach_file,color: Colors.grey,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(Icons.subdirectory_arrow_left_sharp, color: Colors.blue),
                            onPressed: () {
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 2),
                            child: TextField(
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
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(Icons.subdirectory_arrow_right_sharp, color: Colors.blue),
                            onPressed: () {
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.emoji_emotions_outlined,color: Colors.grey,),
              ],
            ),
          ],

        ),
      ),
    );
  }
}
