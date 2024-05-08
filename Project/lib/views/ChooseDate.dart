import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:project/views/BookAppointment.dart'; // Make sure this import matches the location of your BookAppointmentPage file

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
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
              onPressed: _selectedDate == null ? null : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookAppointmentPage(initialDate: _selectedDate),
                  ),
                );
              },
              child: Text('Check Availability'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
