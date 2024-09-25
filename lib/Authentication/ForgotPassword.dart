import 'package:flutter/material.dart';
import 'package:gmailapp/Authentication/CreateAccount.dart';
import 'package:gmailapp/Home/HomeScreen.dart';
import 'package:gmailapp/HomePage.dart';



class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              'EaseSmith',
              style: TextStyle(
                // fontFamily: 'Roboto',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Find your email',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Enter your phone number or recovery email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            SizedBox(height: 40),
            Container(
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Phone number or email',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400
                      ),
                      border:InputBorder.none
                  ),
                ),
              ),
            ),

            Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 110,
                  height: 50,
                  child: ElevatedButton(

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>GmailHomePage(email: "",password: "",)));

                      // Handle Next button action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      minimumSize: Size(double.infinity, 50), // Full-width button
                    ),
                    child: Text('Next',style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
