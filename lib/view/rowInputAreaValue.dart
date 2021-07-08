import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RowInputAreaValue extends StatelessWidget {
  TextEditingController _controller;
  String hint;
  int lines;
  int maxLength;
  bool isEditable;
  TextInputAction inputAction;

  RowInputAreaValue(this._controller, {this.isEditable = true, this.hint, this.lines, this.maxLength, this.inputAction = TextInputAction.next});

  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLines: lines,
        textCapitalization: TextCapitalization.sentences,
        enabled: isEditable,
        controller: _controller,
        textInputAction: inputAction,
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))));
  }
}
