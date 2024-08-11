import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'inspection_categories_page.dart'; // Import the new page

class InspectionHeaderPage extends StatefulWidget {
  final String vehicle;
  final String location;
  final String clientName;
  final String phone;

  InspectionHeaderPage({
    required this.vehicle,
    required this.location,
    required this.clientName,
    required this.phone,
  });

  @override
  _InspectionHeaderPageState createState() => _InspectionHeaderPageState();
}

class _InspectionHeaderPageState extends State<InspectionHeaderPage> {
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _truckModelController = TextEditingController();
  final TextEditingController _inspectionIdController = TextEditingController();
  final TextEditingController _inspectorNameController =
      TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _serviceMeterHoursController =
      TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerIdController = TextEditingController();
  final SignatureController _signatureController =
      SignatureController(penStrokeWidth: 5, penColor: Colors.black);
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _autoFillFields();
    _startVoiceGuide();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  void _autoFillFields() {
    _inspectorNameController.text =
        "John Doe"; // Example: Replace with actual inspector name
    _employeeIdController.text =
        "EMP12345"; // Example: Replace with actual employee ID
    _dateTimeController.text =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    _inspectionIdController.text = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Example auto-incremented ID
  }

  Future<void> _captureSerialNumber() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _serialNumberController.text =
          "735EJ73245"; // Replace with actual OCR result in the future
    }
  }

  Future<void> _getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _locationController.text =
        "${_locationData.latitude}, ${_locationData.longitude}";
  }

  Future<void> _startVoiceGuide() async {
    await _flutterTts
        .speak("Fill in the details and sign at the end to begin inspection.");
  }

  void _clearSignature() {
    _signatureController.clear();
  }

  void _saveSignature() async {
    final signature = await _signatureController.toPngBytes();
    if (signature != null) {
      // Save the signature image or use it as needed
      // For example, you can save it to local storage or upload it to a server
    }
  }

  void _stopVoiceGuide() async {
    await _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Inspection Details',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white, // Set the background to white
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTextField(
                      _serialNumberController, 'Truck Serial Number',
                      icon: Icons.camera_alt, onTap: _captureSerialNumber),
                  _buildTextField(_truckModelController, 'Truck Model'),
                  _buildTextField(_inspectionIdController, 'Inspection ID',
                      readOnly: true),
                  _buildTextField(_inspectorNameController, 'Inspector Name',
                      readOnly: true),
                  _buildTextField(
                      _employeeIdController, 'Inspection Employee ID',
                      readOnly: true),
                  _buildTextField(
                      _dateTimeController, 'Date & Time of Inspection',
                      readOnly: true),
                  _buildTextField(_locationController, 'Location of Inspection',
                      icon: Icons.location_on, onTap: _getCurrentLocation),
                  _buildTextField(_serviceMeterHoursController,
                      'Service Meter Hours (Odometer reading)'),
                  _buildTextField(
                      _customerNameController, 'Customer Name / Company name'),
                  _buildTextField(_customerIdController, 'CAT Customer ID'),
                  SizedBox(height: 20),
                  Text('Inspector Signature'),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFFFCD11), width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Signature(
                          controller: _signatureController,
                          backgroundColor: Colors.white,
                          height: 150,
                          width: 300,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.save, color: Colors.black),
                              onPressed: _saveSignature,
                            ),
                            IconButton(
                              icon: Icon(Icons.clear, color: Colors.black),
                              onPressed: _clearSignature,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _stopVoiceGuide();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InspectionCategoriesPage()), // Navigate to the new page
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: Color(0xFFFFCD11),
                          width: 2), // Caterpillar yellow border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Start Inspection',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {IconData? icon, VoidCallback? onTap, bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          suffixIcon: icon != null
              ? IconButton(icon: Icon(icon), onPressed: onTap)
              : null,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xFFFFCD11)), // Caterpillar yellow
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xFFFFCD11)), // Caterpillar yellow
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
