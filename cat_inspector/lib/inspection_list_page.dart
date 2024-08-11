import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'employee_login_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'inspection_header_page.dart';

class InspectionListPage extends StatefulWidget {
  @override
  _InspectionListPageState createState() => _InspectionListPageState();
}

class _InspectionListPageState extends State<InspectionListPage> {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: logout,
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
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: inspections.length,
                itemBuilder: (context, index) {
                  final inspection = inspections[index];
                  if (searchQuery.isNotEmpty &&
                      !inspection['vehicle']!
                          .toLowerCase()
                          .contains(searchQuery)) {
                    return Container();
                  }
                  return _buildInspectionContainer(
                    context,
                    inspection['vehicle']!,
                    inspection['location']!,
                    inspection['clientName']!,
                    inspection['phone']!,
                    inspection['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionContainer(
    BuildContext context,
    String vehicle,
    String location,
    String clientName,
    String phone,
    String image,
  ) {
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
        trailing:
            Image.asset(image, width: 50, height: 50), // Image on the right
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
                clientName: clientName,
                phone: phone,
              ),
            ),
          );
        },
      ),
    );
  }
}
