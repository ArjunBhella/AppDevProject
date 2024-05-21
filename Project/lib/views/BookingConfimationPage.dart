import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/MyAppointmentsPage.dart';
import '../Models/Doctor.dart';

class BookingConfirmationPage extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String userName;
  final Doctor selectedDoctor;

  BookingConfirmationPage({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.userName,
    required this.selectedDoctor,
  }) : super(key: key);

  final TextEditingController appointmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmation"),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Date: ${selectedDate.toString().substring(0, 10)} at $selectedTime",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 20),
                Text(
                  "Doctor: ${selectedDoctor.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: appointmentNameController,
                  decoration: InputDecoration(
                    labelText: "Enter a name for the appointment",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.teal),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _confirmBooking(context),
                    child: Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmBooking(BuildContext context) async {
    if (appointmentNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an appointment name")),
      );
      return;
    }

    // Check if the selected date and time are already booked with the same doctor
    final isBooked = await DatabaseHelper().isTimeSlotBookedForDoctor(
      "${selectedDate.toString().substring(0, 10)} at $selectedTime",
      selectedDoctor.id,
    );

    if (isBooked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("This time slot is already booked for the selected doctor. Please choose another.")),
      );
      return;
    }

    // If not booked, proceed with booking
    await DatabaseHelper().addAppointment(
      userName,
      appointmentNameController.text,
      "${selectedDate.toString().substring(0, 10)} at $selectedTime",
      selectedDoctor.id, // Save the selected doctor's ID
    );

    // Navigate to the appointments page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyAppointmentsPage(userName: userName)),
    );
  }
}




