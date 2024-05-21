import 'package:flutter/material.dart';
import 'package:project/views/WelcomScreen.dart';
import 'package:project/views/MyAppointmentsPage.dart';

class AppointmentDeletedPage extends StatelessWidget {
  final String username;

  AppointmentDeletedPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Deleted'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Appointment Deleted',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppointmentsPage(userName: username)),
                );
              },
              child: Text('View Your Appointments'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // background color
                foregroundColor: Colors.white, // text color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen(username: username)),
                );
              },
              child: Text('Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // background color
                foregroundColor: Colors.white, // text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
