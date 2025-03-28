import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class alarm extends StatefulWidget {
  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      TimePickerDialog(initialTime: TimeOfDay.fromDateTime(DateTime.now())),
        
    );



  }
}