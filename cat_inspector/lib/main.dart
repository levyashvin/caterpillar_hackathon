import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'employee_login_page.dart';
import 'inspection_list_page.dart';
import 'inspection_header_page.dart';
import 'inspection_categories_page.dart';
import 'tire_inspection_page.dart';
import 'confirmation_page.dart'; // Import the new page

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
        '/login': (context) => const EmployeeLoginPage(),
        '/inspections': (context) => InspectionListPage(),
        '/inspectionHeader': (context) => InspectionHeaderPage(
              vehicle: 'Example Vehicle',
              location: 'Example Location',
              clientName: 'Example Client',
              phone: '123-456-7890',
            ),
        '/inspectionCategories': (context) => InspectionCategoriesPage(
              inspectionDetails: {}, // Pass initial data if needed
              tireImages: [], // Pass initial image list if needed
            ),
        '/tireInspection': (context) => TireInspectionPage(),
        '/confirmation': (context) => ConfirmationPage(
              details: {}, // Pass initial data if needed
              images: [], // Pass initial image list if needed
            ),
      },
    );
  }
}
