import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {

  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('MM-dd-yyyy');

  void _showDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(2025),
    ).then((value) => 
      setState(() => 
        _selectedDate = value!
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.white), 
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.grey)
                  ),
                ),
            ),
            onPressed: _showDatePicker,
            child: const Text(
              'Select Date', 
              style: TextStyle(
                color: Colors.blue, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Text(
          _dateFormat.format(_selectedDate), 
          style: const TextStyle(fontSize: 25.0),
        ),
      ],
    );
  }
}

