import 'package:controle_pacientes/model/patient.dart';
import 'package:controle_pacientes/model/therapeuticPlanning.dart';
import 'package:controle_pacientes/repository/therapeuticPlanningRepository.dart';
import 'package:controle_pacientes/therapeuticPlanning/therapeuticPlanningScreen.dart';
import 'package:controle_pacientes/view/therapeuticCard.dart';
import 'package:flutter/material.dart';

class TherapeuticPlanningListScreen extends StatefulWidget {
  final Patient _patient;

  TherapeuticPlanningListScreen(this._patient);

  @override
  _TherapeuticPlanningListScreenState createState() =>
      _TherapeuticPlanningListScreenState(_patient);
}

class _TherapeuticPlanningListScreenState
    extends State<TherapeuticPlanningListScreen> implements OnFinishPlanning {
  Patient _patient;
  TherapeuticPlanningRepository _repository = TherapeuticPlanningRepository();

  _TherapeuticPlanningListScreenState(this._patient);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Atendimentos",
            textDirection: TextDirection.ltr,
          ),
        ),
        body: FutureBuilder(
          future: _repository.getTherapeuticPlanningsByPatient(_patient),
          builder: (context, data) {
            if (data.hasData) {
              List<TherapeuticPlanning> plannings =
                  data.data as List<TherapeuticPlanning>;

              return ListView.builder(
                padding: EdgeInsets.only(bottom: 76),
                itemBuilder: (context, index) {
                  TherapeuticPlanning planning = plannings[index];
                  return GestureDetector(
                    child: TherapeuticCard(planning, this),
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TherapeuticPlanningScreen(planning)))
                          .then((value) {
                        setState(() {});
                      });
                    },
                  );
                },
                itemCount: plannings.length,
                scrollDirection: Axis.vertical,
              );
            }

            if (data.hasError) {
              if (data.error is NoSuchMethodError) {
                return Center(
                  heightFactor: 5,
                    child: Text("Paciente sem atendimentos",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)));
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () async {
        TherapeuticPlanning planning =
            await _repository.createTherapeuticPlanning(_patient);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TherapeuticPlanningScreen(planning))).then((value) {
          setState(() {});
        });
      }, label: Text("Adicionar atendimento"),
      icon: Icon(Icons.add),),
    );
  }

  @override
  void onFinishFlick(TherapeuticPlanning planning) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja finalizar este planejamento?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "NÃO",
                    style: TextStyle(color: Colors.grey),
                  )),
              TextButton(
                  onPressed: () {
                    _repository.finishTherapeuticPlanning(planning);
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "SIM",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          );
        });
  }
}

abstract class OnFinishPlanning {
  void onFinishFlick(TherapeuticPlanning planning);
}
