import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'employee_login_page.dart';
import 'inspection_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      },
    );
  }
}
