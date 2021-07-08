import 'package:flutter/material.dart';

class DateLabel extends StatelessWidget {
  String label;

  DateLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold));
  }
}
