import 'package:flutter/material.dart';
import 'package:project/Models/Doctor.dart';
import 'package:project/Models/DoctorService.dart';
import 'package:project/views/BookingConfimationPage.dart';

class DoctorSelectionPage extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String userName;

  DoctorSelectionPage({
    required this.selectedDate,
    required this.selectedTime,
    required this.userName,
  });

  @override
  _DoctorSelectionPageState createState() => _DoctorSelectionPageState();
}

class _DoctorSelectionPageState extends State<DoctorSelectionPage> {
  final DoctorService doctorService = DoctorService();
  late Future<List<Doctor>> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = doctorService.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Doctor'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Doctor>>(
          future: futureDoctors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Doctor> doctors = snapshot.data!;
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  Doctor doctor = doctors[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doctor.image),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.teal),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookingConfirmationPage(
                              selectedDate: widget.selectedDate,
                              selectedTime: widget.selectedTime,
                              userName: widget.userName,
                              selectedDoctor: doctor,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

