import 'package:flutter/material.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/DoctorsPage.dart';

class BookAppointmentPage extends StatefulWidget {
  final String userName;
  final DateTime initialDate;

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
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Time Slots',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: timeSlots.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        timeSlots[index],
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        setState(() {
                          selectedTime = timeSlots[index];
                        });
                        _navigateToDoctorSelection();
                      },
                      trailing: selectedTime == timeSlots[index]
                          ? Icon(Icons.check_circle, color: Colors.teal)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedTime != null ? _navigateToDoctorSelection : null,
        label: Text('Next'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: selectedTime != null ? Colors.teal : Colors.grey,
      ),
    );
  }

  void _navigateToDoctorSelection() {
    if (selectedTime != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DoctorSelectionPage(
            selectedDate: widget.initialDate,
            selectedTime: selectedTime!,
            userName: widget.userName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a time slot before proceeding.")),
      );
    }
  }
}
