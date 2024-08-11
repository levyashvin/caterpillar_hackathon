import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ConfirmationPage extends StatelessWidget {
  final Map<String, String> details;
  final List<File> images;

  ConfirmationPage({required this.details, required this.images});

  Future<void> _generateCsv(BuildContext context) async {
    // Create the CSV data
    List<String> rows = ["Field,Value"];

    // Add the details
    details.forEach((key, value) {
      rows.add('$key,$value');
    });

    // Combine all rows into a single string
    String csvData = rows.join('\n');

    // Get the directory to save the CSV
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/inspection_report.csv";

    // Save the CSV file
    final file = File(path);
    await file.writeAsString(csvData);

    // Notify the user
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Report saved at $path")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _generateCsv(context),
          child: Text('Confirm and Generate Report'),
        ),
      ),
    );
  }
}
