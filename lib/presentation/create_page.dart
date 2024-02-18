import 'package:countdown_app/create_components/calendar.dart';
import 'package:countdown_app/create_components/repeat_toggle.dart';
import 'package:countdown_app/create_components/time_select.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {

  CreatePage({super.key});

  final _nameController = TextEditingController();

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
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue), 
              ),
              onPressed: () {},
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
              // color: Colors.green,
              padding: const EdgeInsets.all(15.0),
              // alignment: Alignment.center,
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
      
                  Container(
                    // padding: EdgeInsets.all(5.0),
                    child: const RepeatToggle()
                  ),
      
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
      
                  const MyCalendar(),
      
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
      
                  const TimeSelect(),
                  
      
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
