import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'employee_login_page.dart';
import 'Auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/MiningTruck1.mp4')
      ..initialize().then((_) {
        setState(() {}); // Update the UI when the video is loaded
        _controller.setLooping(true);
        _controller.setVolume(0.0);// Loop the video
        _controller.play(); // Play the video automatically
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Video
          Positioned.fill(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : Container(
              color: Colors.black, // Display a black screen while loading
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
                    // Navigate to EmployeeLoginPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
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
