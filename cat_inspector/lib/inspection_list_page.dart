import 'package:flutter/material.dart';
import 'employee_login_page.dart'; // Ensure this import is included

class InspectionListPage extends StatelessWidget {
  final List<Map<String, String>> inspections = [
    {
      'vehicle': '424 Backhoe Loader',
      'location': 'Lucknow',
      'clientName': 'Aditya Avi',
      'phone': '9336063710'
    },
    {
      'vehicle': '730 Articulated Trucks',
      'location': 'Trichy',
      'clientName': 'Yuva Yashvin',
      'phone': '8778044994'
    },
    {
      'vehicle': 'CW34 Roller',
      'location': 'Delhi',
      'clientName': 'Yuvraj',
      'phone': '9818378372'
    },
    {
      'vehicle': '836 Landfill Compactor',
      'location': 'Bengaluru',
      'clientName': 'Chinamy',
      'phone': '9563148521'
    },
    {
      'vehicle': '310 Mini Excavator',
      'location': 'Chennai',
      'clientName': 'Abiram',
      'phone': '9564317975'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Your Tasks',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Remove the back button
        actions: [
          TextButton(
            onPressed: () {
              // Handle sign out
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => EmployeeLoginPage()),
              );
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: inspections.length,
          itemBuilder: (context, index) {
            final inspection = inspections[index];
            return Card(
              color: Color(0xFFFFCD11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vehicle: ${inspection['vehicle']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Location: ${inspection['location']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Client Name: ${inspection['clientName']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Phone: ${inspection['phone']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
