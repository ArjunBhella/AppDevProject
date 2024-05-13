import 'package:flutter/material.dart';
import 'package:project/views/ChooseDate.dart';
import 'package:project/views/MyAppointmentsPage.dart';
import 'package:project/views/DoctorsPage.dart'; // Import the DoctorsPage

class WelcomeScreen extends StatelessWidget {
  final String username;

  WelcomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome $username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookAppointmentScreen(userName: username),
                  ),
                );
              },
              child: Text('Book an Appointment'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyAppointmentsPage(userName: username),
                  ),
                );
              },
              child: Text('View My Appointments'),
            ),
            SizedBox(height: 20), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the DoctorsPage
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DoctorsPage(), // Assuming DoctorsPage does not require a username
                  ),
                );
              },
              child: Text('View Doctors'),
            ),
          ],
        ),
      ),
    );
  }
}


