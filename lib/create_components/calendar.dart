import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({
    super.key,
    required this.dateGetter,
    required this.dateSetter,
  });

  final ValueGetter<DateTime> dateGetter;
  final ValueSetter<DateTime> dateSetter;

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {

  final DateFormat _dateFormat = DateFormat('MM-dd-yyyy');

  void _showCalendar() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(2025),
    ).then((newDate) => 
      setState(() => 
        widget.dateSetter(newDate ?? widget.dateGetter()),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 40.0,
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
            onPressed: _showCalendar,
            child: Text(
              _dateFormat.format(widget.dateGetter()), 
              style: const TextStyle(
                color: Colors.blue, 
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    );
  }
}

