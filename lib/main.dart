import 'package:flutter/material.dart';
import 'package:gmailapp/Authentication/LoginScreen.dart';
import 'package:gmailapp/Home/HomeScreen.dart';
import 'package:gmailapp/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(GmailApp());
}



class GmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Gmail Clone',
      home: SignInScreen(),
    );
  }
}




