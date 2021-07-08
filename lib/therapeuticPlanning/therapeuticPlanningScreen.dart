import 'package:controle_pacientes/model/therapeuticPlanning.dart';
import 'package:controle_pacientes/multidisciplinaryVisit/multidisciplinaryVisitScreen.dart';
import 'package:controle_pacientes/repository/therapeuticPlanningRepository.dart';
import 'package:controle_pacientes/view/bottomSpace.dart';
import 'package:controle_pacientes/view/dateLabel.dart';
import 'package:controle_pacientes/view/rowInputAreaValue.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:controle_pacientes/view/rowName.dart';
import 'package:controle_pacientes/view/rowValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TherapeuticPlanningScreen extends StatefulWidget {
  TherapeuticPlanning _planning;

  TherapeuticPlanningScreen(this._planning);

  @override
  _TherapeuticPlanningScreenState createState() =>
      _TherapeuticPlanningScreenState(this._planning);
}

class _TherapeuticPlanningScreenState extends State<TherapeuticPlanningScreen> {
  TherapeuticPlanning _planning;
  bool _isFinished;

  MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
      mask: "##-##-####", filter: {"#": RegExp(r'[0-9]')});

  _TherapeuticPlanningScreenState(this._planning) {
    _isFinished = _planning.isFinished;
  }

  final TherapeuticPlanningRepository _repository =
      TherapeuticPlanningRepository();

  TextEditingController attendanceController;
  TextEditingController admissionDateController;
  TextEditingController admissionDateHospitalController;
  TextEditingController hospitalizationReasonController;
  TextEditingController comorbiditiesController;
  TextEditingController responsibleController;

  void initControllers() {
    attendanceController = TextEditingController(text: _planning.attendance);
    admissionDateController =
        TextEditingController(text: _planning.admissionDate);
    admissionDateHospitalController =
        TextEditingController(text: _planning.admissionDateHospital);
    hospitalizationReasonController =
        TextEditingController(text: _planning.hospitalizationReason);
    comorbiditiesController =
        TextEditingController(text: _planning.comorbidities);
    responsibleController = TextEditingController(text: _planning.responsible);
  }

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planejamento Terapêutico"),
        actions: [
          Visibility(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Deseja salvar este planejamento?"),
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
                              onPressed: () async {
                                updateTherapeuticPlanning();
                                String result = await _repository
                                    .saveTherapeuticPlanning(_planning);
                                if (result == "Success") {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  showAlertDialog(context, result);
                                }
                              },
                              child: Text(
                                "SIM",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ))
                        ],
                      );
                    });
              },
              child: Padding(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(right: 16.0),
              ),
            ),
            visible: !_isFinished,
          ),
        ],
      ),
      body: FutureBuilder(
        future: _repository.getTherapeuticPlanning(_planning),
        builder: (context, data) {
          if (data.hasData) {
            _planning = data.data as TherapeuticPlanning;

            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                color: Colors.grey[50],
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RowName("Paciente"),
                                  Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: RowValue(_planning.patient.name))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RowName("Idade"),
                                    Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: RowValue(_planning.patient.age))
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RowName("Atendimento"),
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: RowInputValue(
                                          attendanceController,
                                          "Código",
                                          align: TextAlign.start,
                                          isEditable: !_isFinished,
                                        )),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 16.0, top: 16.0),
                                        child: DateLabel("Data de Admissão")),
                                    Padding(
                                        padding: EdgeInsets.only(left: 16.0, top: 16.0),
                                        child: DateLabel("Admissão na unidade"))
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: RowInputValue(
                                          admissionDateController, "Data",
                                          formatter: dateFormatter,
                                          inputType: TextInputType.number,
                                          isEditable: !_isFinished),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: RowInputValue(
                                          admissionDateHospitalController, "Data",
                                          formatter: dateFormatter,
                                          inputType: TextInputType.number,
                                          isEditable: !_isFinished),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 24),
                                      child: RowName("Agente de saúde responsável"))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RowInputValue(
                                      responsibleController,
                                      "Nome",
                                      isEditable: !_isFinished,
                                      align: TextAlign.start,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    RowName("1. Motivo da internação")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: RowInputAreaValue(
                                            hospitalizationReasonController,
                                            hint:
                                            "Descreva para facilitar o atendimento...",
                                            lines: 4,
                                            maxLength: 300,
                                            isEditable: !_isFinished),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: RowName("Comorbidades"))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: RowInputAreaValue(comorbiditiesController,
                                            hint: "Deixar em branco caso inexistente",
                                            lines: 2,
                                            inputAction: TextInputAction.done,
                                            maxLength: 100,
                                            isEditable: !_isFinished),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    RowName('Visitas Multidisciplinares')
                                  ],
                                ),
                                getMultidisciplinaryButtons(context)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        Padding(
                            padding: EdgeInsets.only(top: 36),
                            child: TextButton(
                              child: Text(
                                "REMOVER ATENDIMENTO",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Deseja excluir este planejamento?"),
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
                                                _repository.removeTherapeuticPlanning(_planning);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "SIM",
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor),
                                              ))
                                        ],
                                      );
                                    });
                              },
                            ))
                      ]),
                      BottomSpace()
                    ],
                  ),
                )));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: !_isFinished,
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MultidisciplinaryVisitScreen(_planning)))
                  .then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add),
            label: Text(
              "Adicionar visita",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Column getMultidisciplinaryButtons(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);

    if (_planning.multidisciplinaryVisit != null &&
        _planning.multidisciplinaryVisit.isNotEmpty) {
      var visits = _planning.multidisciplinaryVisit
          .map((visit) => Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      child: Text(
                        visit.date,
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MultidisciplinaryVisitScreen(_planning,
                                        visit: visit))).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  )
                ],
              ))
          .toList();
      widgets.addAll(visits);
    } else {
      widgets.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              "Nenhuma visita",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ));
    }

    return Column(
      children: widgets,
    );
  }

  void showAlertDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Erro"),
              content: Text(content),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
  }

  void updateTherapeuticPlanning() {
    _planning.comorbidities = comorbiditiesController.text;
    _planning.attendance = attendanceController.text;
    _planning.admissionDateHospital = admissionDateHospitalController.text;
    _planning.admissionDate = admissionDateController.text;
    _planning.hospitalizationReason = hospitalizationReasonController.text;
    _planning.responsible = responsibleController.text;
  }
}
