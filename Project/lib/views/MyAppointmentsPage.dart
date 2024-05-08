import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart'; // Import the DatabaseHelper

class MyAppointmentsPage extends StatefulWidget {
  final String userName;

  const MyAppointmentsPage({Key? key, required this.userName}) : super(key: key);

  @override
  _MyAppointmentsPageState createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  late Future<List<Map<String, dynamic>>> _futureAppointments;

  @override
  void initState() {
    super.initState();
    _futureAppointments = _fetchAppointments();
  }

  Future<List<Map<String, dynamic>>> _fetchAppointments() async {
    return await DatabaseHelper().getAppointmentsByUser(widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureAppointments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final appointments = snapshot.data!;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return ListTile(
                  title: Text(appointment['appointment_name'] ?? ''),
                  subtitle: Text(appointment['date'] ?? ''),
                );
              },
            );
          } else {
            return Center(child: Text('No appointments found.'));
          }
        },
      ),
    );
  }
}
