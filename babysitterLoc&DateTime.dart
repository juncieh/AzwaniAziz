import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_picker/flutter_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Babysitter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BabysitterScreen(),
    );
  }
}

class BabysitterScreen extends StatefulWidget {
  @override
  _BabysitterScreenState createState() => _BabysitterScreenState();
}

class _BabysitterScreenState extends State<BabysitterScreen> {
  String _location = 'Unknown';
  DateTime? _selectedDateTime; // Initialized as nullable DateTime

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    });
  }

  void _selectDateTime() {
    Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(
        type: PickerDateTimeType.kYMDHM,
        isNumberMonth: true,
      ),
      title: Text("Select Date and Time"),
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          _selectedDateTime = (picker.adapter as DateTimePickerAdapter).value;
        });
      },
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Babysitter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Set Location (GPS)'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Location: $_location',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectDateTime,
              child: Text('Set Date & Time'),
            ),
            SizedBox(height: 16.0),
            Text(
              _selectedDateTime != null
                  ? 'Selected Date & Time: $_selectedDateTime'
                  : 'Please select a date & time',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
