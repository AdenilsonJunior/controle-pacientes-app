import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormatterUtil {
  FormatterUtil._();

  static TextInputFormatter getDateFormatter() {
    return MaskTextInputFormatter(
        mask: "##-##-####", filter: {'#': RegExp(r'[0-9]')});
  }

  static TextInputFormatter getTimeFormatter() {
    return MaskTextInputFormatter(
        mask: "##:##", filter: {"#": RegExp(r'[0-9]')});
  }

  static TextInputFormatter getCPFFormatter() {
    return MaskTextInputFormatter(
        mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  }
}
