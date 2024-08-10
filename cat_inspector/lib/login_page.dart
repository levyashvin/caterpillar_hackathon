import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/truck_background.png',
              fit: BoxFit.cover, // Ensure the image scales to fit the screen
            ),
          ),
          // Overlay with Caterpillar logo and buttons
          Column(
            children: [
              SizedBox(height: 100),
              Image.asset(
                'assets/caterpillar_logo.png',
                width: 200,
                height: 100,
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign-in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFFFCD11), // Caterpillar yellow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle create account
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.white), // Outline color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40), // Add some space at the bottom
            ],
          ),
        ],
      ),
    );
  }
}
