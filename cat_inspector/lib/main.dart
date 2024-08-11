import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'employee_login_page.dart';
import 'inspection_list_page.dart';
import 'inspection_header_page.dart'; // Import the InspectionHeaderPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAT Inspect App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => EmployeeLoginPage(),
        '/inspections': (context) => InspectionListPage(),
        '/inspectionHeader': (context) => InspectionHeaderPage(
              vehicle: 'Example Vehicle',
              location: 'Example Location',
              clientName: 'Example Client',
              phone: '123-456-7890',
            ),
      },
    );
  }
}
