import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'employee_login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class InspectionListPage extends StatefulWidget {

  @override
  _InspectionListPageState createState() => _InspectionListPageState();
}

class _InspectionListPageState extends State<InspectionListPage> {

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      // Handle sign-out error if any
      print('Sign out error: $e');
    }
  }
  final List<Map<String, String>> inspections = [
    {
      'vehicle': '424 Backhoe Loader',
      'location': 'Lucknow',
      'clientName': 'Aditya Avi',
      'phone': '9336063710',
      'image': 'assets/424_backhoe_loader.jpg'
    },
    {
      'vehicle': '730 Articulated Trucks',
      'location': 'Trichy',
      'clientName': 'Yuva Yashvin',
      'phone': '8778044994',
      'image': 'assets/310_mini_excavator.jpeg'
    },
    {
      'vehicle': 'CW34 Roller',
      'location': 'Delhi',
      'clientName': 'Yuvraj',
      'phone': '9818378372',
      'image': 'assets/cw34_roller.jpeg'
    },
    {
      'vehicle': '836 Landfill Compactor',
      'location': 'Bengaluru',
      'clientName': 'Chinamy',
      'phone': '9563148521',
      'image': 'assets/836_landfill_compactor.jpeg'
    },
    {
      'vehicle': '310 Mini Excavator',
      'location': 'Chennai',
      'clientName': 'Abiram',
      'phone': '9564317975',
      'image': 'assets/310_mini_excavator.jpeg'
    },
  ];

  String searchQuery = "";
import 'inspection_header_page.dart';

class InspectionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        backgroundColor: Colors.white, // Set the app bar background to white
        title: Text(
          'Your Tasks',
          style: TextStyle(color: Colors.black), // Set the title color to black
        ),
        actions: [
          TextButton(
            onPressed: logout,
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle sign out
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Black background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
              ),
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white), // White text
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white, // Set the background to white
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFFCD11)), // Caterpillar yellow
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFFCD11)), // Caterpillar yellow
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildInspectionContainer(
                      context, '424 Backhoe Loader', 'Pune', '123-456-7890'),
                  _buildInspectionContainer(context, '370 Articulated Truck',
                      'Mumbai', '234-567-8901'),
                  _buildInspectionContainer(
                      context, 'CW34 Roller', 'Delhi', '345-678-9012'),
                  _buildInspectionContainer(context, '836 Landfill Compactor',
                      'Chennai', '456-789-0123'),
                  _buildInspectionContainer(context, '310 Mini Excavator',
                      'Bangalore', '567-890-1234'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionContainer(
      BuildContext context, String vehicle, String location, String phone) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: Color(0xFFFFCD11)), // Caterpillar yellow border
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        trailing: Image.asset('assets/$vehicle.png',
            width: 50, height: 50), // Image on the right
        title: Text(vehicle),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location: $location'),
            Text('Client Phone: $phone'),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InspectionHeaderPage(
                vehicle: vehicle,
                location: location,
                clientName: 'Client Name', // Replace with actual client name
                phone: phone,
              ),
            ),
          );
        },
      ),
    );
  }
}
