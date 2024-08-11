import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  void initState() {
    super.initState();
    _autoFillFields();
  }

  void _autoFillFields() {
    // Auto-fill the inspector name, employee ID, and date/time fields
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
      // Process the image (dummy data used here)
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

  void _saveSignature() async {
    final signature = await _signatureController.toPngBytes();
    if (signature != null) {
      // Save the signature image or use it as needed
      // For example, you can save it to local storage or upload it to a server
    }
  }

  void _clearSignature() {
    _signatureController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspection Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white, // Set the background to white
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_serialNumberController, 'Truck Serial Number',
                  icon: Icons.camera_alt, onTap: _captureSerialNumber),
              _buildTextField(_truckModelController, 'Truck Model'),
              _buildTextField(_inspectionIdController, 'Inspection ID',
                  readOnly: true),
              _buildTextField(_inspectorNameController, 'Inspector Name',
                  readOnly: true),
              _buildTextField(_employeeIdController, 'Inspection Employee ID',
                  readOnly: true),
              _buildTextField(_dateTimeController, 'Date & Time of Inspection',
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
                  // Proceed to the next step
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
