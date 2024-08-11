import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TireInspectionPage extends StatefulWidget {
  @override
  _TireInspectionPageState createState() => _TireInspectionPageState();
}

class _TireInspectionPageState extends State<TireInspectionPage> {
  final TextEditingController _leftFrontPressureController =
      TextEditingController();
  final TextEditingController _rightFrontPressureController =
      TextEditingController();
  final TextEditingController _leftRearPressureController =
      TextEditingController();
  final TextEditingController _rightRearPressureController =
      TextEditingController();
  final TextEditingController _overallSummaryController =
      TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  String? _leftFrontCondition;
  String? _rightFrontCondition;
  String? _leftRearCondition;
  String? _rightRearCondition;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'leftFrontPressure', _leftFrontPressureController.text);
    await prefs.setString(
        'rightFrontPressure', _rightFrontPressureController.text);
    await prefs.setString('leftRearPressure', _leftRearPressureController.text);
    await prefs.setString(
        'rightRearPressure', _rightRearPressureController.text);
    await prefs.setString('overallSummary', _overallSummaryController.text);
    await prefs.setString('leftFrontCondition', _leftFrontCondition ?? '');
    await prefs.setString('rightFrontCondition', _rightFrontCondition ?? '');
    await prefs.setString('leftRearCondition', _leftRearCondition ?? '');
    await prefs.setString('rightRearCondition', _rightRearCondition ?? '');
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _leftFrontPressureController.text =
          prefs.getString('leftFrontPressure') ?? '';
      _rightFrontPressureController.text =
          prefs.getString('rightFrontPressure') ?? '';
      _leftRearPressureController.text =
          prefs.getString('leftRearPressure') ?? '';
      _rightRearPressureController.text =
          prefs.getString('rightRearPressure') ?? '';
      _overallSummaryController.text = prefs.getString('overallSummary') ?? '';
      _leftFrontCondition = prefs.getString('leftFrontCondition');
      _rightFrontCondition = prefs.getString('rightFrontCondition');
      _leftRearCondition = prefs.getString('leftRearCondition');
      _rightRearCondition = prefs.getString('rightRearCondition');
    });
  }

  Widget _buildPressureField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        onTap: () => _speak(label),
        decoration: InputDecoration(
          labelText: label,
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

  Widget _buildConditionField(
      String label, String? condition, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildConditionButton(label, 'Good', condition, onChanged),
              _buildConditionButton(label, 'Ok', condition, onChanged),
              _buildConditionButton(
                  label, 'Needs Replacement', condition, onChanged),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionButton(String label, String value, String? condition,
      Function(String?) onChanged) {
    return ElevatedButton(
      onPressed: () {
        onChanged(value);
        _speak(label + ' ' + value);
        _saveData();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: condition == value ? Color(0xFFFFCD11) : Colors.white,
        foregroundColor: condition == value ? Colors.black : Colors.black,
        side: BorderSide(color: Color(0xFFFFCD11)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(value),
    );
  }

  Widget _buildSummaryField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 4,
        onTap: () => _speak(label),
        onChanged: (value) => _saveData(),
        decoration: InputDecoration(
          labelText: label,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tire Inspection',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPressureField(
                  'Tire Pressure for Left Front', _leftFrontPressureController),
              _buildPressureField('Tire Pressure for Right Front',
                  _rightFrontPressureController),
              _buildConditionField(
                  'Tire Condition for Left Front', _leftFrontCondition,
                  (value) {
                setState(() {
                  _leftFrontCondition = value;
                });
              }),
              _buildConditionField(
                  'Tire Condition for Right Front', _rightFrontCondition,
                  (value) {
                setState(() {
                  _rightFrontCondition = value;
                });
              }),
              _buildPressureField(
                  'Tire Pressure for Left Rear', _leftRearPressureController),
              _buildPressureField(
                  'Tire Pressure for Right Rear', _rightRearPressureController),
              _buildConditionField(
                  'Tire Condition for Left Rear', _leftRearCondition, (value) {
                setState(() {
                  _leftRearCondition = value;
                });
              }),
              _buildConditionField(
                  'Tire Condition for Right Rear', _rightRearCondition,
                  (value) {
                setState(() {
                  _rightRearCondition = value;
                });
              }),
              _buildSummaryField(
                  'Overall Tire Summary', _overallSummaryController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(
                      color: Color(0xFFFFCD11),
                      width: 2), // Caterpillar yellow border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 16.0), // Add padding for better appearance
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
