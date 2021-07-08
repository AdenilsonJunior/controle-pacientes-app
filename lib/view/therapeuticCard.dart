import 'package:controle_pacientes/model/therapeuticPlanning.dart';
import 'package:controle_pacientes/therapeuticPlanningList/therapeuticPlanningListScreen.dart';
import 'package:controle_pacientes/view/therapeuticStatusText.dart';
import 'package:flutter/material.dart';

class TherapeuticCard extends StatelessWidget {

  TherapeuticPlanning _planning;
  OnFinishPlanning _onFinishPlanning;

  TherapeuticCard(this._planning, this._onFinishPlanning);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Atendimento " + _getAttendance(),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 16),
                          child: Text(
                            'Admissão: ' + _getAdmissionDate(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 16),
                          child: Text(
                            'Admissão na unidade: ' + _getAdmissionDateHospital(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 8, right: 16),
                            child: Text(
                              'Responsável:  ' + _planning.responsible,
                              style: TextStyle(color: Colors.blue, fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 16),
                          child: _getWidgetByFinished(),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.black38,)
            ],
          )),
      margin: EdgeInsets.all(8.0),
    );
  }

  String _getAdmissionDate() {
   if(_planning.admissionDate != null && _planning.admissionDate.isNotEmpty) {
     return _planning.admissionDate;
   } else {
     return "a definir";
   }
  }

  String _getAdmissionDateHospital() {
    if (_planning.admissionDateHospital != null && _planning.admissionDateHospital.isNotEmpty) {
      return _planning.admissionDateHospital;
    } else {
      return "a denifir";
    }
  }

  String _getAttendance() {
    if(_planning.attendance != null && _planning.attendance.isNotEmpty) {
      return _planning.attendance;
    } else {
      return "a definir";
    }
  } 

  Widget _getWidgetByFinished() {
    if (_planning.isFinished) {
      return TherapeuticStatusText();
    } else {
      return ElevatedButton(child: Text("Finalizar"), onPressed: () {
        if(_onFinishPlanning != null) {
          _onFinishPlanning.onFinishFlick(_planning);
        }
      },);
    }
  }
}