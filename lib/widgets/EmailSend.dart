import 'package:flutter/material.dart';

class EmailSuccessScreen extends StatelessWidget {
  final String to;
  final String cc;
  final String subject;
  final String body;

  EmailSuccessScreen({
    required this.to,
    required this.cc,
    required this.subject,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sent Successfully',style: TextStyle(
          fontSize: 14
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Sent To:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(to),
            SizedBox(height: 8),
            if (cc.isNotEmpty) ...[
              Text(
                'CC:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(cc),
              SizedBox(height: 8),
            ],
            Text(
              'Subject:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(subject),
            SizedBox(height: 16),
            Text(
              'Body:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(body),
            SizedBox(height: 24),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Text('Back to Compose'),
            // ),
          ],
        ),
      ),
    );
  }
}
