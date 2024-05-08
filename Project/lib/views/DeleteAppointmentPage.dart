import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/AppointmentDeletedPage.dart';

class DeleteAppointmentPage extends StatelessWidget {
  final int? appointmentId;
  final String? appointmentName;
  final String? appointmentDate;
  final String username;

  const DeleteAppointmentPage({
    Key? key,
    required this.appointmentId,
    required this.appointmentName,
    required this.appointmentDate,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Name: $appointmentName'),
            Text('Date: $appointmentDate'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper().deleteAppointment(appointmentId!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentDeletedPage(username: username)),
                    );
                  },
                  child: Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Cancel and go back
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
