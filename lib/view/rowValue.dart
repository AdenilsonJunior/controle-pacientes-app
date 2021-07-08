import 'package:flutter/material.dart';

class RowValue extends StatelessWidget {
  final String _value;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  RowValue(this._value, {this.fontSize = 15.0, this.color = Colors.black54, this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(_getValue(), style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight));
  }

  String _getValue() {
    if (_value != null && _value.isNotEmpty) {
      return _value;
    } else {
      return "";
    }
  }
}
