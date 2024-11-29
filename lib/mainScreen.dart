import 'package:flutter/material.dart';
import 'main.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColour,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: implement sign in with Google
                },
                icon: Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    width: 24,
                    height: 24),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      Colors.white, // Background color for the button
                  backgroundColor: Colors.white, // Text and icon color
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2, // Shadow for a realistic button look
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
