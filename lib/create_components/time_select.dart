import 'package:countdown_app/create_components/time_scroll.dart';
import 'package:flutter/material.dart';

class TimeSelect extends StatefulWidget {

  const TimeSelect({
    super.key,
    required this.updateHour,
    required this.updateMinute,
    required this.updateTimeAMPM,
  });

  final Function updateHour;
  final Function updateMinute;
  final Function updateTimeAMPM;

  @override
  State<TimeSelect> createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> with TickerProviderStateMixin {
  
  bool _expanded = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override 
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller, 
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void toggleTimeScroll() {
    _expanded = !_expanded;
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0.0, duration: const Duration(milliseconds: 100));
    }
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 228.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [

          Container(

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: _expanded ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ) : BorderRadius.circular(15.0),
            ),

            child: Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                const Text("All-day"),
                const Spacer(),
                TimeToggleButton(() { toggleTimeScroll(); }
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),

          // Time Scroll
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: Container(
              height: 180, 
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )
              ),
              child: TimeScroll(
                updateHour: widget.updateHour,
                updateMinute: widget.updateMinute,
                updateTimeAMPM: widget.updateTimeAMPM,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class TimeToggleButton extends StatefulWidget {
  const TimeToggleButton(
    this.changeTimeScroll, 
    {super.key}
  );

  final VoidCallback changeTimeScroll;

  @override
  State<TimeToggleButton> createState() => _TimeToggleButtonState();
}

class _TimeToggleButtonState extends State<TimeToggleButton> {

  bool _activeButton = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _activeButton,
      activeColor: Colors.green,
      onChanged: (bool value) {
        setState(() {
          _activeButton = value;
          widget.changeTimeScroll();
        });
      },
    );
  }
}