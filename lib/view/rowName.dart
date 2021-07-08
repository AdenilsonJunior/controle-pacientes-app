import 'package:flutter/material.dart';

class RowName extends StatelessWidget {
  final String _name;
  final double fontSize;
  final Color color;

  RowName(this._name, {this.fontSize = 16, this.color = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_name + ":",
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color)),
    );
  }
}
