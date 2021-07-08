import 'package:flutter/material.dart';

class TherapeuticStatusText extends StatelessWidget {

  TherapeuticStatusText();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Finalizado",
      style: TextStyle(
          color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
