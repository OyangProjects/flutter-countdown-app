import 'package:flutter/material.dart';

class TimeScroll extends StatefulWidget {
  const TimeScroll({
    super.key,
    required this.updateHour,
    required this.updateMinute,
    required this.updateTimeAMPM,
  });

  final Function updateHour;
  final Function updateMinute;
  final Function updateTimeAMPM;

  @override
  State<TimeScroll> createState() => _TimeScrollState();
}

class _TimeScrollState extends State<TimeScroll> {

  final List<int> _timeAMPMList = [ 0, 12 ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        Positioned(
          top: 67.5,
          child: Container(
            width: 350.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: 50.0,
              child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (newHour) {
                  widget.updateHour(newHour);
                },
                itemExtent: 50,
                perspective: 0.003,
                diameterRatio: 0.6,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: List<Widget>.generate(
                    12, (index) => HourScroll(hours: index),
                  ),
                ),
              ),
            ),

            const SizedBox(
              width: 25.0,
            ),

            SizedBox(
              width: 50.0,
              child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (newMinute) {
                  widget.updateMinute(newMinute);
                },
                itemExtent: 50,
                perspective: 0.001,
                diameterRatio: 0.6,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: List<Widget>.generate(
                    60, (index) => MinuteScroll(minutes: index),
                  ),
                ),
              ),
            ),

            const SizedBox(
              width: 10.0,
            ),

            SizedBox(
              width: 50.0,
              child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (newTimeAMPM) {
                  widget.updateTimeAMPM(_timeAMPMList[newTimeAMPM]);
                },
                itemExtent: 50,
                perspective: 0.003,
                diameterRatio: 0.6,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 2, 
                  builder: (context, index) {
                    if (index == 0) {
                      return const TimeAmPm(time: "AM");
                    } else {
                      return const TimeAmPm(time: "PM");
                    }
                  },
                ),
              ),
            ),

          ],
        ),
        
      ]
    );
  }
}

class HourScroll extends StatelessWidget {

  final int hours;

  const HourScroll({required this.hours, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      hours == 0 ? "12" : hours.toString(),
      style: const TextStyle(
        fontSize: 30.0,
        color: Colors.black,
      ),
    );
  }
}

class MinuteScroll extends StatelessWidget {

  final int minutes;

  const MinuteScroll({required this.minutes, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      minutes < 10 ? "0${minutes.toString()}" : minutes.toString(),
      style: const TextStyle(
        fontSize: 30.0,
        color: Colors.black,
      ),
    );
  }
}

class TimeAmPm extends StatelessWidget {

  final String time;

  const TimeAmPm({required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: const TextStyle(
        fontSize: 30.0,
        color: Colors.black,
      ),
    );
  }
}