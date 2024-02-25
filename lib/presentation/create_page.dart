import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_app/create_components/calendar.dart';
import 'package:countdown_app/create_components/repeat_toggle.dart';
import 'package:countdown_app/create_components/time_select.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class CreatePage extends StatefulWidget {

  const CreatePage({
    super.key,
    required this.onCreate,
    required this.firestoreInstance,
  });

  final Function onCreate;
  final CollectionReference firestoreInstance;

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  final TextEditingController _nameController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  // final DateFormat _dateFormat = DateFormat('MM-dd-yyyy');

  int _hour = 0;
  int _minute = 0;
  int _timeOffset = 0;

  DateTime _createDeadline() {
    final DateTime deadline = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _hour + _timeOffset,
      _minute
    );
    return deadline;
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,

        appBar: AppBar(
          centerTitle: true,
          
          title: const Text(
            "New Countdown", 
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              _nameController.dispose();
              Navigator.of(context).pop();
            },
          ),

          actions: [
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue), 
              ),
              onPressed: () {
                Map<String, dynamic> uploadCountdown = {
                  "CountdownName" : _nameController.text,
                  "SelectedDate" : _createDeadline(),
                  "Hour" : _hour,
                  "Minute" : _minute,
                  "TimeOffset" : _timeOffset
                };
                widget.firestoreInstance.add(uploadCountdown).then((DocumentReference doc) =>
                print('DocumentSnapshot added with ID: ${doc.id}'));
                widget.onCreate();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Create', 
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            const SizedBox(
              width: 10.0,
            ),

          ],
          backgroundColor: Colors.grey.shade200,
        ),

        body: ListView(
          children: [

            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  const Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("PICK A NAME",),
                    ],
                  ),
      
                  const SizedBox(
                    height: 5.0,
                  ),
      
                  // Countdown Name Textfield
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Name your countdown",
                    ),
                  ),
      
                  const SizedBox(
                    height: 20.0,
                  ),
      
                  const Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("REPEAT",),
                    ],
                  ),

                  // Toggle Buttons for Repeat Options
                  const RepeatToggle(),
                  
                  const SizedBox(
                    height: 20.0,
                  ),
      
                  const Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("SELECT DATE",),
                    ],
                  ),
                  
                  // Calendar Constructor
                  MyCalendar(
                    dateGetter: () { return _selectedDate; },
                    dateSetter: (DateTime newDate) { _selectedDate = newDate; },
                  ),
      
                  const SizedBox(
                    height: 20.0,
                  ),
      
                  const Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("SELECT TIME",),
                    ],
                  ),
      
                  const SizedBox(
                    height: 5.0,
                  ),

                  // Select Time Constructor
                  TimeSelect(
                    updateHour: (int newHour) { _hour = newHour; },
                    updateMinute: (int newMinute) { _minute = newMinute; },
                    updateTimeAMPM: (int newTimeOffset) { _timeOffset = newTimeOffset; },
                  ),

                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
