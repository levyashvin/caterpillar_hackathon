import 'package:flutter/material.dart';
import 'employee_login_page.dart';

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
      'vehicle': '370 Articulated Trucks',
      'location': 'Trichy',
      'clientName': 'Yuva Yashvin',
      'phone': '8778044994',
      'image': 'assets/370_articulated_trucks.jpeg'
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
        color: Colors.white, // Set the background color to white
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Color(0xFFFFCD11)), // Caterpillar yellow border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Color(0xFFFFCD11)), // Caterpillar yellow border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Color(0xFFFFCD11)), // Caterpillar yellow border
                  ),
                  filled: true,
                  fillColor: Colors.white,
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
                  if (inspection['vehicle']!
                          .toLowerCase()
                          .contains(searchQuery) ||
                      inspection['location']!
                          .toLowerCase()
                          .contains(searchQuery) ||
                      inspection['clientName']!
                          .toLowerCase()
                          .contains(searchQuery) ||
                      inspection['phone']!.contains(searchQuery)) {
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Color(0xFFFFCD11), width: 2),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              inspection['vehicle']!,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 5),
                            Text('Location: ${inspection['location']}',
                                style: TextStyle(color: Colors.black)),
                            Text('Client Name: ${inspection['clientName']}',
                                style: TextStyle(color: Colors.black)),
                            Text('Phone: ${inspection['phone']}',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        trailing: Image.asset(
                          inspection['image']!,
                          width: 70, // Increased width
                          height: 70, // Increased height
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
