import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'employee_login_page.dart';
import 'inspection_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'inspection_header_page.dart';
import 'inspection_categories_page.dart';
import 'tire_inspection_page.dart'; // Import the new page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        // '/login': (context) => EmployeeLoginPage(context),
        '/inspections': (context) => InspectionListPage(),
        '/inspectionHeader': (context) => InspectionHeaderPage(
              vehicle: 'Example Vehicle',
              location: 'Example Location',
              clientName: 'Example Client',
              phone: '123-456-7890',
            ),
        '/inspectionCategories': (context) => InspectionCategoriesPage(),
        '/tireInspection': (context) =>
            TireInspectionPage(), // Add the new route
      },
    );
  }
}
