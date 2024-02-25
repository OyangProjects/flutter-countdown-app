import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTile extends StatefulWidget {
  const CountdownTile({
    super.key,
    required this.countdownName,
    required this.hour,
    required this.minute,
    required this.timeOffset,
    required this.deadline,
  });

  final String countdownName;
  final int hour;
  final int minute;
  final int timeOffset;
  final DateTime deadline;

  @override
  State<CountdownTile> createState() => _CountdownTileState();
}

class _CountdownTileState extends State<CountdownTile> {

  final List<String> _months = [
    "JAN", "FEB", "MAR", "APR", "MAY", "JUNE", "JULY", "AUG", "SEP",
    "OCT", "NOV", "DEC"
  ];
  
  late Timer _timer;
  late Duration _duration; 
  late String _deadlineText;

  
  @override
  void initState() {

    final seconds = widget.deadline.difference(DateTime.now()).inSeconds;
    _duration = Duration(seconds: seconds);

    _deadlineText = "${_months[widget.deadline.month - 1]} ${widget.deadline.day.toString()}, ${widget.deadline.year.toString()} ${widget.hour == 0 ? "12" : widget.hour.toString()}:${widget.minute < 10 ? "0${widget.minute.toString()}" : widget.minute.toString()} ${widget.timeOffset == 0 ? "AM" : "PM"}";

    _timer = Timer.periodic(
      const Duration(seconds: 1), 
      (_) { 
        if (_duration.inSeconds > 0) {
          _timerTick();
        } else {
          _timer.cancel();
          setState(() {});
        }
      },
    );

    super.initState();

  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  void _timerTick() {
    setState(() {
      _duration = Duration(seconds: _duration.inSeconds - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: MediaQuery.of(context).size.width - 35,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15.0),
        // image: const DecorationImage(
        //   image: INSERT IMAGE,
        //   // image: AssetImage('assets/images/fuhualaying.jpg'),
        //   fit: BoxFit.cover,
        //   opacity: 1.0,
        // ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Container(
              // color: Colors.green,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "PERSONAL",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    widget.countdownName,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _deadlineText,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
              ]),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.black.withOpacity(0.60),
              child: _countdownInfo(),
            ),
          ),
        ]),
    );
  }

  Widget _countdownInfo() {
    if (_duration.inSeconds > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_timeRemainingText(), 
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Text(_timeUnitRemainingText(), 
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Icon(
          Icons.check,
          size: 50.0,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              blurRadius: 10.0,
              color: Colors.black,
            ),
          ],
      ));
    }
  }

  String _timeRemainingText() {
    if (_duration.inDays > 0) {
      return (_duration.inDays + 1).toString();
    } else if (_duration.inHours > 0) {
      return (_duration.inHours + 1).toString();
    } else if (_duration.inMinutes > 0) {
      return (_duration.inMinutes + 1).toString();
    } else {
      return _duration.inSeconds.toString();
    }
  } 

  String _timeUnitRemainingText() {
    if (_duration.inDays > 0) {
      return "Days Left";
    } else if (_duration.inHours > 0) {
      return "Hours Left";
    } else if (_duration.inMinutes > 0) {
      return "Minutes Left";
    } else {
      return "Seconds Left";
    }
  }

}
