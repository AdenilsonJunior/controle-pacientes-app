import 'package:controle_pacientes/addPatient/addPatientScreen.dart';
import 'package:controle_pacientes/model/patient.dart';
import 'package:controle_pacientes/model/section.dart';
import 'package:controle_pacientes/repository/patientRepository.dart';
import 'package:controle_pacientes/therapeuticPlanningList/therapeuticPlanningListScreen.dart';
import 'package:flutter/material.dart';
import 'package:controle_pacientes/view/patientCard.dart';

class PatientListScreen extends StatefulWidget {
  Section _section;

  PatientListScreen(this._section);

  @override
  _PatientListScreenState createState() => _PatientListScreenState(_section);
}

class _PatientListScreenState extends State<PatientListScreen> {
  Section _section;

  PatientRepository _repository = PatientRepository();

  _PatientListScreenState(this._section);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de pacientes", textDirection: TextDirection.ltr),
      ),
      body: FutureBuilder(
          future: _repository.getPatients(_section),
          builder: (context, data) {
            if (data.hasData) {
              List<Patient> patients = data.data as List<Patient>;
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 76.0),
                itemBuilder: (context, index) {
                  Patient patient = patients[index];
                  return GestureDetector(
                    child: PatientCard(patient, (Patient patient) {
                      showDeletePatientDialog(context, patient);
                    }),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TherapeuticPlanningListScreen(patient)));
                    },
                  );
                },
                itemCount: patients.length,
                scrollDirection: Axis.vertical,
              );
            }

            if (data.hasError) {
              if (data.error is NoSuchMethodError) {
                return Center(
                    heightFactor: 5,
                    child: Text("Copa sem pacientes",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)));
              }
              return Text("Erro ao retornar os pacientes");
            }

            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPatientScreen(_section)))
              .then((value) {
            setState(() {});
          });
        },
        label: Text(
          "Adicionar Paciente",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.add),
      ),
    );
  }

  void showDeletePatientDialog(BuildContext context, Patient patient) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
       title: Text('Atenção'),
       content: Text('Tem certeza que deseja remover este paciente?'),
       actions: [
         TextButton(onPressed: () {
           Navigator.pop(context);
         }, child: Text('NÃO', style: TextStyle(color: Colors.grey[600]),)),
         TextButton(onPressed: () {
           _repository.removePatient(patient);
           Navigator.pop(context);
           setState(() {});
         }, child: Text('SIM', style: TextStyle(color: Colors.blue),))
       ],
      );
    });
  }
}


