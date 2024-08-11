import 'package:flutter/material.dart';
import 'tire_inspection_page.dart'; // Import the new page

class InspectionCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspection Categories',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width
          children: [
            _buildCategoryButton(context, 'Tires'),
            _buildCategoryButton(context, 'Battery'),
            _buildCategoryButton(context, 'Exterior'),
            _buildCategoryButton(context, 'Brakes'),
            _buildCategoryButton(context, 'Engine'),
            _buildCategoryButton(context, 'Voice of Customer'),
            SizedBox(height: 20),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: () {
          if (category == 'Tires') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TireInspectionPage()), // Navigate to the TireInspectionPage
            );
          }
          // Handle other categories similarly
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(
              color: Color(0xFFFFCD11), width: 2), // Caterpillar yellow border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(
              vertical: 16.0), // Add padding for better appearance
        ),
        child: Text(
          category,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle submit action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(
              vertical: 16.0), // Add padding for better appearance
        ),
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
