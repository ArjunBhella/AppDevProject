import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

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
              'Book an Appointment',
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
              headerTextStyle: TextStyle(color: Colors.white),
              nextMonthDayBorderColor: Colors.white,
              weekendTextStyle: TextStyle(color: Colors.white), // Weekends text color
              weekdayTextStyle: TextStyle(color: Colors.white), // Weekdays text color
              todayTextStyle: TextStyle(color: Colors.white), // Today's text color
              selectedDayTextStyle: TextStyle(color: Colors.black), // Selected day text color
              selectedDayButtonColor: Colors.white, // Selected day button color
              selectedDayBorderColor: Colors.white, // Selected day border color
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(
                text: _selectedDate != null
                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : '',
              ),
              decoration: InputDecoration(

                labelText: 'Selected Date',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add logic for checking availability
            },
            child: Text('Check Availability'),
          ),
        ],
      ),
    );
  }
}
