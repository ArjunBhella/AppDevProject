import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:project/views/BookAppointment.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String userName;
  final DateTime? initialDate;

  const BookAppointmentScreen({Key? key, required this.userName, this.initialDate}) : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Book an Appointment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Select a Date',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: CalendarCarousel(
              onDayPressed: (DateTime date, List<dynamic> events) {
                setState(() {
                  _selectedDate = date;
                });
              },
              thisMonthDayBorderColor: Colors.grey,
              headerTextStyle: TextStyle(color: Colors.white),
              nextMonthDayBorderColor: Colors.white,
              weekendTextStyle: TextStyle(color: Colors.white),
              weekdayTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
              selectedDayTextStyle: TextStyle(color: Colors.black),
              selectedDayButtonColor: Colors.white,
              selectedDayBorderColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Selected Date: ${_selectedDate?.toString().substring(0, 10) ?? 'None'}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: _selectedDate == null ? null : _navigateToAppointmentPage,
              child: Text('Check Availability'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.lightBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAppointmentPage() {
    if (_selectedDate != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookAppointmentPage(
            initialDate: _selectedDate!,
            userName: widget.userName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a date before proceeding.")),
      );
    }
  }
}
