import 'package:flutter/material.dart';
import 'package:controle_pacientes/model/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final Function(Patient) callback;

  PatientCard(this.patient, this.callback);

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
                              patient.name,
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
                            'Idade: ' + patient.age,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, right: 24.0),
                          child: Text(
                            'Leito: ' + patient.hospitalBed,
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, right: 16.0),
                          child: Text(
                            'Médico: ' + patient.doctor,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0, right: 24.0),
                              child: Text(
                                'Dieta: ' + patient.lastDiet,
                                maxLines: 10,
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black45),
                              ),
                            )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16.0, right: 24.0),
                          child: Text(
                            'Entrada às ' + patient.entry,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16.0, right: 24.0),
                          child: ElevatedButton(
                            onPressed: () {
                              callback(patient);
                            },
                            child: Text('Remover'),
                          ),
                        )
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
}
