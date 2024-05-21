import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/DeleteAppointmentPage.dart';

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
        backgroundColor: Colors.teal,
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
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      appointment['appointment_name'] ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(appointment['date'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteAppointmentPage(
                              appointmentId: appointment['appointment_id'],
                              appointmentName: appointment['appointment_name'],
                              appointmentDate: appointment['date'],
                              username: widget.userName,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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

