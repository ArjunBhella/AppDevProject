import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/MyAppointmentsPage.dart';
class BookingConfirmationPage extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String userName;

  BookingConfirmationPage({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.userName,
  }) : super(key: key);

  final TextEditingController appointmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Date: ${selectedDate.toString().substring(0, 10)} at $selectedTime",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: appointmentNameController,
              decoration: InputDecoration(
                labelText: "Enter a name for the appointment",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmBooking(context),
              child: Text('Confirm'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmBooking(BuildContext context) async {
    if (appointmentNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an appointment name")),
      );
      return;
    }

    // Use DatabaseHelper to save the appointment
    await DatabaseHelper().addAppointment(
      userName,
      appointmentNameController.text,
      "${selectedDate.toString().substring(0, 10)} at $selectedTime",
    );

    // Navigate to the appointments page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyAppointmentsPage(userName: userName)),
    );
  }
}
