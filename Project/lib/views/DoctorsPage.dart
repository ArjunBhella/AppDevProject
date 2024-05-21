
import 'package:flutter/material.dart';
import 'package:project/Models/Doctor.dart';
import 'package:project/Models/DoctorService.dart';

class DoctorsPage extends StatefulWidget {
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
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
        title: Text('Doctors'),
      ),
      body: FutureBuilder<List<Doctor>>(
        future: futureDoctors,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Doctor> doctors = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                Doctor doctor = doctors[index];
                return Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(doctor.image),
                      ),
                      SizedBox(height: 10),
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
