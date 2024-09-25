import 'package:flutter/material.dart';
class Meeting extends StatefulWidget {
  const Meeting({super.key});

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Meeting")),
    );
  }
}
