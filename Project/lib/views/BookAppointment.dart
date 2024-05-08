import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart'; // Make sure this import points to your DatabaseHelper file
import 'package:project/views/BookingConfimationPage.dart';
class BookAppointmentPage extends StatefulWidget {
  final String userName;  // Assuming the username is passed to this page
  final DateTime initialDate; // Adding initialDate as a required parameter

  BookAppointmentPage({Key? key, required this.userName, required this.initialDate}) : super(key: key);

  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  List<String> timeSlots = [];
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    _loadTimeSlots();
  }

  Future<void> _loadTimeSlots() async {
    timeSlots = await DatabaseHelper().getTimeSlots();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time Slot'),
      ),
      body: timeSlots.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(timeSlots[index]),
            onTap: () {
              setState(() {
                selectedTime = timeSlots[index];
              });
              _navigateToConfirmation();
            },
          );
        },
      ),
    );
  }

  void _navigateToConfirmation() {
    if (selectedTime != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookingConfirmationPage(
            selectedDate: widget.initialDate, // Using initialDate from the widget
            selectedTime: selectedTime!,
            userName: widget.userName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a time slot before confirming."))
      );
    }
  }
}
