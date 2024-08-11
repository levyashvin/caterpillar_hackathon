import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ConfirmationPage extends StatelessWidget {
  final Map<String, String> details;
  final List<File> images;

  ConfirmationPage({required this.details, required this.images});

  Future<void> _generatePdf() async {
    final pdf = pw.Document();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/report.pdf');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Inspection Report',
                style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Details:', style: const pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            ...details.entries
                .map((entry) => pw.Text('${entry.key}: ${entry.value}')),
            pw.SizedBox(height: 20),
            pw.Text('Images:', style: const pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            ...images.map(
                (image) => pw.Image(pw.MemoryImage(image.readAsBytesSync()))),
          ],
        ),
      ),
    );

    await file.writeAsBytes(await pdf.save());
    await Printing.sharePdf(
        bytes: await file.readAsBytes(), filename: 'report.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _generatePdf,
          child: const Text('Confirm and Generate Report'),
        ),
      ),
    );
  }
}
