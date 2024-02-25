import 'package:flutter/material.dart';

// Set text to bold color if selected

const List<Widget> repeatOptions = [
  Text("Off"),
  Text("Daily"),
  Text("Weekly"),
  Text("Monthly"),
  Text("Yearly"),
];

class RepeatToggle extends StatefulWidget {
  const RepeatToggle({super.key});

  @override
  State<RepeatToggle> createState() => _RepeatToggleState();
}

class _RepeatToggleState extends State<RepeatToggle> {

  final List<bool> _selectedRepeat = [true, false, false, false, false];

  @override 
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < _selectedRepeat.length; buttonIndex++) {
            if (buttonIndex == index) {
              _selectedRepeat[buttonIndex] = true;
            } else {
              _selectedRepeat[buttonIndex] = false;
            }
          }
        });
      },
      borderRadius: BorderRadius.circular(15.0),
      selectedBorderColor: Colors.grey,
      selectedColor: Colors.black87,
      fillColor: Colors.white,
      color: Colors.black,
      constraints: BoxConstraints(
        minWidth: (MediaQuery.of(context).size.width - 36)/ 5,
        minHeight: 40.0,
      ),
      isSelected: _selectedRepeat,
      children: repeatOptions, 
    );
  }
}