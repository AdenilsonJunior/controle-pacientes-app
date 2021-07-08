import 'package:controle_pacientes/util/upperCaseFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RowInputValue extends StatefulWidget {
  String _hint;
  TextEditingController _controller;
  TextAlign align;
  TextInputType inputType;
  bool isEditable;
  bool isObscured;
  MaskTextInputFormatter formatter;
  bool isUpperCase;
  TextInputAction inputAction;

  RowInputValue(this._controller, this._hint,
      {this.align = TextAlign.center, this.inputType = TextInputType
          .text, this.isEditable = true, this.isObscured = false, this.formatter, this.isUpperCase = false,
      this.inputAction = TextInputAction.next});

  @override
  _RowInputValueState createState() =>
      _RowInputValueState(
          this._controller, this._hint, this.align, this.inputType,
          this.isEditable, this.isObscured, this.formatter, this.isUpperCase, this.inputAction);
}

class _RowInputValueState extends State<RowInputValue> {
  String _hint;
  TextAlign _align;
  TextEditingController _controller;
  TextInputType _inputType;
  bool isEditable;
  bool isObscured;
  MaskTextInputFormatter formatter;
  bool isUpperCase;
  TextInputAction inputAction;

  _RowInputValueState(this._controller, this._hint, this._align,
      this._inputType, this.isEditable, this.isObscured, this.formatter, this.isUpperCase, this.inputAction);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controller,
        textAlign: _align,
        enabled: isEditable,
        keyboardType: _inputType,
        textCapitalization: TextCapitalization.sentences,
        obscureText: isObscured,
        textInputAction: inputAction,
        inputFormatters: _getFormatters(),
        decoration: InputDecoration(
            labelText: _hint,
            border: UnderlineInputBorder()
        )
    );
  }

  List<TextInputFormatter> _getFormatters() {
    List<TextInputFormatter> formatters = List.empty(growable: true);

    if(formatter != null) {
      formatters.add(formatter);
    }

    if(isUpperCase) {
      formatters.add(UpperCaseTextFormatter());
    }


    return formatters;
  }
}

