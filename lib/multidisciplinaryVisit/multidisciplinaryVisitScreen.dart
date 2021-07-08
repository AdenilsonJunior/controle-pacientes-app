import 'package:controle_pacientes/model/multidisciplinaryVisit.dart';
import 'package:controle_pacientes/model/therapeuticPlanning.dart';
import 'package:controle_pacientes/repository/therapeuticPlanningRepository.dart';
import 'package:controle_pacientes/util/dateUtil.dart';
import 'package:controle_pacientes/view/rowInputAreaValue.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:controle_pacientes/view/rowName.dart';
import 'package:controle_pacientes/view/rowValue.dart';
import 'package:flutter/material.dart';

class MultidisciplinaryVisitScreen extends StatefulWidget {
  TherapeuticPlanning planning;
  MultidisciplinaryVisit visit;

  MultidisciplinaryVisitScreen(this.planning, {this.visit});

  @override
  _MultidisciplinaryVisitScreenState createState() {
    initVisit();
    return _MultidisciplinaryVisitScreenState(planning, visit);
  }

  void initVisit() {
    if (visit == null) {
      visit = MultidisciplinaryVisit.newInstance();
    }
  }
}

class _MultidisciplinaryVisitScreenState
    extends State<MultidisciplinaryVisitScreen> {
  TherapeuticPlanning planning;
  MultidisciplinaryVisit visit;
  TherapeuticPlanningRepository _repository = TherapeuticPlanningRepository();

  TextEditingController _responsibleController;
  TextEditingController _complicationsController;
  TextEditingController _vitalSignalChangesController;
  TextEditingController _diuresisVolumeController;
  TextEditingController _diuresisCharacteristicsController;
  TextEditingController _laboratoryTestsController;
  TextEditingController _woundSkinRiskController;
  TextEditingController _gastricProtectionController;
  TextEditingController _bronchoaspirationController;
  TextEditingController _protocolTEVController;
  TextEditingController _cultureController;
  TextEditingController _infectionPreventionController;
  TextEditingController _maintenanceJustificationController;
  TextEditingController _useATBController;
  TextEditingController _useATBDaysController;
  TextEditingController _vomitingController;
  TextEditingController _evacuationController;
  TextEditingController _diuresisVolumeRiskController;
  TextEditingController _diuresisCharacteristicsRiskController;
  TextEditingController _drainsTypesController;
  TextEditingController _drainsVolumeController;
  TextEditingController _operativeWoundsLocalController;
  TextEditingController _pendenciesController;
  TextEditingController _lastVisitGoalController;
  TextEditingController _examsProceduresEvaluationsController;
  TextEditingController _nighRoundController;
  TextEditingController _goal1Controller;
  TextEditingController _goal2Controller;
  TextEditingController _goal3Controller;
  TextEditingController _goal4Controller;
  TextEditingController _goal5Controller;
  TextEditingController _participantsController;

  _MultidisciplinaryVisitScreenState(this.planning, this.visit);

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visita dia: " + getVisitDate()),
        actions: [
          Visibility(
              visible: isEditable(),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Deseja salvar esta visita?"),
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
                                  updateVisit();
                                  String result = await _repository.saveVisit(planning, visit);
                                  if(result == "Success") {
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
              )),
          Visibility(
              visible: !isEditable(),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Deseja remover esta visita?"),
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
                                  _repository.removeVisit(planning, visit);
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
                child: Padding(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(right: 16.0),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                RowName(
                  'Agente de saúde responsável',
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RowInputValue(
                        _responsibleController,
                        'Nome:',
                        align: TextAlign.start,
                        isEditable: isEditable(),
                      )),
                )
              ],
            ),
            Row(
              children: [
                RowName(
                  '2. Evolução clínica',
                  color: Colors.blue,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.lightBlue[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Intercorrências?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Não"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Não",
                          groupValue: visit.clinicalEvolution.complications.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.complications.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Sim"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Sim",
                          groupValue: visit.clinicalEvolution.complications.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.complications.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.clinicalEvolution.complications.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _complicationsController,
                              maxLength: 300,
                              hint: "Quais?",
                              lines: 2,
                              isEditable: isEditable(),
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.lightBlue[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Alterações de sinais vitais?',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text("Não"),
                        visualDensity: VisualDensity(
                          horizontal: 0,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 4, left: 0, right: 0, bottom: 4),
                        leading: Radio<String>(
                            value: "Não",
                            groupValue:
                                visit.clinicalEvolution.vitalSignalChanges.has,
                            onChanged: (String value) {
                              if (isEditable()) {
                                setState(() {
                                  visit.clinicalEvolution.vitalSignalChanges
                                      .has = value;
                                });
                              }
                            }),
                      ),
                      ListTile(
                        title: Text("Sim"),
                        visualDensity: VisualDensity(
                          horizontal: 0,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 4, left: 0, right: 0, bottom: 4),
                        leading: Radio<String>(
                            value: "Sim",
                            groupValue:
                                visit.clinicalEvolution.vitalSignalChanges.has,
                            onChanged: (String value) {
                              if (isEditable()) {
                                setState(() {
                                  visit.clinicalEvolution.vitalSignalChanges
                                      .has = value;
                                });
                              }
                            }),
                      ),
                      Visibility(
                          visible: hasExtraInformation(
                              visit.clinicalEvolution.vitalSignalChanges.has),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8, left: 8, right: 8, bottom: 8),
                              child: RowInputAreaValue(
                                _vitalSignalChangesController,
                                maxLength: 300,
                                hint: "Quais?",
                                isEditable: isEditable(),
                                lines: 2,
                              ))),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.lightBlue[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Controle glicêmico:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Adequado"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Adequado",
                          groupValue: visit.clinicalEvolution.glycemicControl,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.glycemicControl = value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Inadequado"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Inadequado",
                          groupValue: visit.clinicalEvolution.glycemicControl,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.glycemicControl = value;
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.lightBlue[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: RowValue(
                            'Diurese:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RowInputValue(
                                _diuresisVolumeController,
                                'Volume:',
                                align: TextAlign.start,
                                isEditable: isEditable(),
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _diuresisCharacteristicsController,
                            hint: 'Características:',
                            isEditable: isEditable(),
                            maxLength: 100,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.lightBlue[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: RowValue(
                            'Evacuação:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      title: Text("Presente"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Presente",
                          groupValue: visit.clinicalEvolution.evacuation,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.evacuation = value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Ausente"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Ausente",
                          groupValue: visit.clinicalEvolution.evacuation,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.evacuation = value;
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.lightBlue[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Exames laboratoriais?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Não"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Não",
                          groupValue:
                              visit.clinicalEvolution.laboratoryTests.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.laboratoryTests.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Sim"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Sim",
                          groupValue:
                              visit.clinicalEvolution.laboratoryTests.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.clinicalEvolution.laboratoryTests.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.clinicalEvolution.laboratoryTests.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _laboratoryTestsController,
                              maxLength: 300,
                              hint: "Quais:",
                              lines: 2,
                              isEditable: isEditable(),
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.lightBlue[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Exames de imagem',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.clinicalEvolution.imageTests
                                  .contains("TC"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.clinicalEvolution.imageTests
                                          .add("TC");
                                    } else {
                                      visit.clinicalEvolution.imageTests
                                          .remove("TC");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'TC',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.clinicalEvolution.imageTests
                                  .contains("RM"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.clinicalEvolution.imageTests
                                          .add("RM");
                                    } else {
                                      visit.clinicalEvolution.imageTests
                                          .remove("RM");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'RM',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.clinicalEvolution.imageTests
                                  .contains("RAIO - X"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.clinicalEvolution.imageTests
                                          .add("RAIO - X");
                                    } else {
                                      visit.clinicalEvolution.imageTests
                                          .remove("RAIO - X");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'RAIO - X',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.clinicalEvolution.imageTests
                                  .contains("US"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.clinicalEvolution.imageTests
                                          .add("US");
                                    } else {
                                      visit.clinicalEvolution.imageTests
                                          .remove("US");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'US',
                            color: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  RowName(
                    '3. Riscos e protocolos',
                    color: Colors.red,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Risco de lesão de pele?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Não"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Não",
                          groupValue: visit.risksAndProtocols.woundSkinRisk.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.woundSkinRisk.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Sim"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Sim",
                          groupValue: visit.risksAndProtocols.woundSkinRisk.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.woundSkinRisk.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.risksAndProtocols.woundSkinRisk.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _woundSkinRiskController,
                              maxLength: 300,
                              hint: "Ação:",
                              isEditable: isEditable(),
                              lines: 2,
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Broncoaspiração?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Não"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Não",
                          groupValue:
                              visit.risksAndProtocols.bronchoaspiration.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.bronchoaspiration.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Sim"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Sim",
                          groupValue:
                              visit.risksAndProtocols.bronchoaspiration.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.bronchoaspiration.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.risksAndProtocols.bronchoaspiration.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _bronchoaspirationController,
                              maxLength: 300,
                              isEditable: isEditable(),
                              hint: "Ação:",
                              lines: 2,
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Proteção gástrica?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Não"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Não",
                          groupValue:
                              visit.risksAndProtocols.gastricProtection.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.gastricProtection.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Sim"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Sim",
                          groupValue:
                              visit.risksAndProtocols.gastricProtection.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.gastricProtection.has =
                                    value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.risksAndProtocols.gastricProtection.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _gastricProtectionController,
                              maxLength: 300,
                              hint: "Quais:",
                              isEditable: isEditable(),
                              lines: 2,
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.red[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Protocolo TEV',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.risksAndProtocols.tevProtocol.options
                                  .contains("heparina não fracionada"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit
                                          .risksAndProtocols.tevProtocol.options
                                          .add("heparina não fracionada");
                                    } else {
                                      visit
                                          .risksAndProtocols.tevProtocol.options
                                          .remove("heparina não fracionada");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'heparina não fracionada',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.risksAndProtocols.tevProtocol.options
                                  .contains("exonaparina"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit
                                          .risksAndProtocols.tevProtocol.options
                                          .add("exonaparina");
                                    } else {
                                      visit
                                          .risksAndProtocols.tevProtocol.options
                                          .remove("exonaparina");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'exonaparina',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Padding(
                            padding: EdgeInsets.all(8),
                            child: RowInputAreaValue(
                              _protocolTEVController,
                              hint: 'Outros:',
                              maxLength: 100,
                              isEditable: isEditable(),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.red[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Cultura',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Padding(
                            padding: EdgeInsets.all(8),
                            child: RowInputAreaValue(
                              _cultureController,
                              lines: 3,
                              isEditable: isEditable(),
                              hint: 'Características:',
                              maxLength: 100,
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.red[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Prevenção de infecção',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit
                                  .risksAndProtocols.infectionPrevention.options
                                  .contains("CVC"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.risksAndProtocols
                                          .infectionPrevention.options
                                          .add("CVC");
                                    } else {
                                      visit.risksAndProtocols
                                          .infectionPrevention.options
                                          .remove("CVC");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'CVC',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit
                                  .risksAndProtocols.infectionPrevention.options
                                  .contains("SVD"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.risksAndProtocols
                                          .infectionPrevention.options
                                          .add("SVD");
                                    } else {
                                      visit.risksAndProtocols
                                          .infectionPrevention.options
                                          .remove("SVD");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'SVD',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Padding(
                            padding: EdgeInsets.all(8),
                            child: RowInputAreaValue(
                              _infectionPreventionController,
                              hint: 'Outros:',
                              isEditable: isEditable(),
                              maxLength: 100,
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.red[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Justificativa de manutenção',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Padding(
                            padding: EdgeInsets.all(8),
                            child: RowInputAreaValue(
                              _maintenanceJustificationController,
                              lines: 3,
                              isEditable: isEditable(),
                              hint: 'Justificativa:',
                              maxLength: 100,
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: RowValue(
                            'Uso ATB:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RowInputValue(
                                _useATBController,
                                'ATB:',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _useATBDaysController,
                            hint: 'Dias:',
                            isEditable: isEditable(),
                            maxLength: 100,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.red[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Precaução',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.risksAndProtocols.precaution
                                  .contains("contato"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.risksAndProtocols.precaution
                                          .add("contato");
                                    } else {
                                      visit.risksAndProtocols.precaution
                                          .remove("contato");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'contato',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.risksAndProtocols.precaution
                                  .contains("gotículas"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.risksAndProtocols.precaution
                                          .add("gotículas");
                                    } else {
                                      visit.risksAndProtocols.precaution
                                          .remove("gotículas");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'gotículas',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.risksAndProtocols.precaution
                                  .contains("aerossóis"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.risksAndProtocols.precaution
                                          .add("aerossóis");
                                    } else {
                                      visit.risksAndProtocols.precaution
                                          .remove("aerossóis");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'aerossóis',
                            color: Colors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Analgesia?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Adequado"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Adequado",
                          groupValue: visit.risksAndProtocols.analgesia,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.analgesia = value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Inadequado"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Inadequado",
                          groupValue: visit.risksAndProtocols.analgesia,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.analgesia = value;
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Vômitos?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Não"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Não",
                          groupValue: visit.risksAndProtocols.vomiting.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.vomiting.has = value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Sim"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Sim",
                          groupValue: visit.risksAndProtocols.vomiting.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.vomiting.has = value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.risksAndProtocols.vomiting.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _vomitingController,
                              maxLength: 300,
                              isEditable: isEditable(),
                              hint: "Ação e aspecto:",
                              lines: 2,
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Evacuação?',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Ausente"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Ausente",
                          groupValue: visit.risksAndProtocols.evacuation.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.evacuation.has = value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Presente"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Presente",
                          groupValue: visit.risksAndProtocols.evacuation.has,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.risksAndProtocols.evacuation.has = value;
                              });
                            }
                          }),
                    ),
                    Visibility(
                        visible: hasExtraInformation(
                            visit.risksAndProtocols.evacuation.has),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: RowInputAreaValue(
                              _evacuationController,
                              maxLength: 300,
                              hint: "Aspecto:",
                              lines: 2,
                              isEditable: isEditable(),
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.red[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: RowValue(
                            'Diurese:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RowInputValue(
                                _diuresisVolumeRiskController,
                                'Volume:',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _diuresisCharacteristicsRiskController,
                            hint: 'Características:',
                            isEditable: isEditable(),
                            maxLength: 100,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  RowName(
                    '4. Dieta',
                    color: Colors.green,
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.lightGreen[50],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: RowValue(
                              'Dieta',
                              fontSize: 13,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.diet.diet.contains("V.O"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.diet.diet.add("V.O");
                                    } else {
                                      visit.diet.diet.remove("V.O");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'V.O',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.diet.diet.contains("SNE"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.diet.diet.add("SNE");
                                    } else {
                                      visit.diet.diet.remove("SNE");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'SNE',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.diet.diet.contains("NPP"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.diet.diet.add("NPP");
                                    } else {
                                      visit.diet.diet.remove("NPP");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'NPP',
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: visit.diet.diet.contains("JEJUNO/GASTRO"),
                              onChanged: (checked) {
                                if (isEditable()) {
                                  setState(() {
                                    if (checked) {
                                      visit.diet.diet.add("JEJUNO/GASTRO");
                                    } else {
                                      visit.diet.diet.remove("JEJUNO/GASTRO");
                                    }
                                  });
                                }
                              }),
                          RowValue(
                            'JEJUNO/GASTRO',
                            color: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.lightGreen[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: RowValue(
                            'Drenos:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _drainsTypesController,
                            hint: 'Tipos:',
                            isEditable: isEditable(),
                            maxLength: 100,
                          ),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RowInputValue(
                                _drainsVolumeController,
                                'Volume:',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  RowName(
                    '5. Feridas Operatórias',
                    color: Colors.deepOrange,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.deepOrange[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: RowValue(
                            'Local:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _operativeWoundsLocalController,
                            hint: 'Descrição:',
                            maxLength: 100,
                            isEditable: isEditable(),
                            lines: 2,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  RowName(
                    '6. Fisioterapia',
                    color: Colors.cyan,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.cyan[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Tipo:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text("Motora"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Motora",
                          groupValue: visit.physiotherapy,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.physiotherapy = value;
                              });
                            }
                          }),
                    ),
                    ListTile(
                      title: Text("Respiratória"),
                      visualDensity: VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 4, left: 0, right: 0, bottom: 4),
                      leading: Radio<String>(
                          value: "Respiratória",
                          groupValue: visit.physiotherapy,
                          onChanged: (String value) {
                            if (isEditable()) {
                              setState(() {
                                visit.physiotherapy = value;
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  RowName(
                    '7. Pendências',
                    color: Colors.brown,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.brown[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Pendências:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _pendenciesController,
                            hint: 'Descrição:',
                            maxLength: 100,
                            isEditable: isEditable(),
                            lines: 2,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.brown[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Metas da última visita:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _lastVisitGoalController,
                            hint: 'Descrição:',
                            maxLength: 100,
                            isEditable: isEditable(),
                            lines: 2,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.brown[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Exames, procedimentos e avaliações',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _examsProceduresEvaluationsController,
                            hint: 'Quais:',
                            maxLength: 100,
                            isEditable: isEditable(),
                            lines: 2,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                    child: RowName(
                      '8. Round noturno (definir com equipe médica)',
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.amber[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _nighRoundController,
                            hint: 'Descrição:',
                            isEditable: isEditable(),
                            maxLength: 100,
                            lines: 2,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                    child: RowName(
                      '9. Metas (Revisão em voz para conferência da equipe)',
                      color: Colors.purple,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.purple[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: RowValue(
                            'Metas:',
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: RowInputValue(
                                _goal1Controller,
                                '1 -',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: RowInputValue(
                                _goal2Controller,
                                '2 -',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: RowInputValue(
                                _goal3Controller,
                                '3 -',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: RowInputValue(
                                _goal4Controller,
                                '4 -',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: RowInputValue(
                                _goal5Controller,
                                '5 -',
                                isEditable: isEditable(),
                                align: TextAlign.start,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  RowName(
                    '10. Participantes',
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.blueGrey[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RowInputAreaValue(
                            _participantsController,
                            hint: 'Separe os nomes por vírgula:',
                            maxLength: 100,
                            isEditable: isEditable(),
                            lines: 2,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  String getVisitDate() {
    if (visit.date == null) {
      DateTime now = DateTime.now();
      visit.date = DateUtil.getDateFormatted(now);
    }
    return visit.date;
  }

  bool hasExtraInformation(String has) {
    if (has == "Sim" || has == "Presente") {
      return true;
    } else {
      return false;
    }
  }

  void updateVisit() {
    visit.responsible = _responsibleController.text;

    visit.clinicalEvolution.complications.which = _complicationsController.text;
    visit.clinicalEvolution.vitalSignalChanges.which =
        _vitalSignalChangesController.text;
    visit.clinicalEvolution.diuresis.volume = _diuresisVolumeController.text;
    visit.clinicalEvolution.diuresis.characteristics =
        _diuresisCharacteristicsController.text;
    visit.clinicalEvolution.laboratoryTests.which =
        _laboratoryTestsController.text;

    visit.risksAndProtocols.woundSkinRisk.which = _woundSkinRiskController.text;
    visit.risksAndProtocols.bronchoaspiration.which =
        _bronchoaspirationController.text;
    visit.risksAndProtocols.gastricProtection.which =
        _gastricProtectionController.text;
    visit.risksAndProtocols.tevProtocol.others = _protocolTEVController.text;
    visit.risksAndProtocols.culture = _cultureController.text;
    visit.risksAndProtocols.infectionPrevention.others =
        _infectionPreventionController.text;
    visit.risksAndProtocols.maintenanceJustification =
        _maintenanceJustificationController.text;
    visit.risksAndProtocols.atbUse.atb = _useATBController.text;
    visit.risksAndProtocols.atbUse.days = _useATBDaysController.text;
    visit.risksAndProtocols.vomiting.which = _vomitingController.text;
    visit.risksAndProtocols.evacuation.which = _evacuationController.text;
    visit.risksAndProtocols.diuresis.volume =
        _diuresisVolumeRiskController.text;
    visit.risksAndProtocols.diuresis.characteristics =
        _diuresisCharacteristicsRiskController.text;

    visit.diet.drains.types = _drainsTypesController.text;
    visit.diet.drains.volume = _drainsVolumeController.text;

    visit.operativeWoundsLocal = _operativeWoundsLocalController.text;

    visit.pendencies.pendency = _pendenciesController.text;
    visit.pendencies.lastVisitGoal = _lastVisitGoalController.text;
    visit.pendencies.examsProceduresEvaluations =
        _examsProceduresEvaluationsController.text;

    visit.nightRound = _nighRoundController.text;

    visit.goals.goal1 = _goal1Controller.text;
    visit.goals.goal2 = _goal2Controller.text;
    visit.goals.goal3 = _goal3Controller.text;
    visit.goals.goal4 = _goal4Controller.text;
    visit.goals.goal5 = _goal5Controller.text;

    visit.participants = _participantsController.text;
  }

  void initControllers() {
    _responsibleController = TextEditingController(text: visit.responsible);
    _complicationsController = TextEditingController(
        text: visit.clinicalEvolution.complications.which);
    _vitalSignalChangesController = TextEditingController(
        text: visit.clinicalEvolution.vitalSignalChanges.which);
    _diuresisVolumeController =
        TextEditingController(text: visit.clinicalEvolution.diuresis.volume);
    _diuresisCharacteristicsController = TextEditingController(
        text: visit.clinicalEvolution.diuresis.characteristics);
    _laboratoryTestsController = TextEditingController(
        text: visit.clinicalEvolution.laboratoryTests.which);
    _woundSkinRiskController = TextEditingController(
        text: visit.risksAndProtocols.woundSkinRisk.which);
    _gastricProtectionController = TextEditingController(
        text: visit.risksAndProtocols.gastricProtection.which);
    _bronchoaspirationController = TextEditingController(
        text: visit.risksAndProtocols.bronchoaspiration.which);
    _protocolTEVController =
        TextEditingController(text: visit.risksAndProtocols.tevProtocol.others);
    _cultureController =
        TextEditingController(text: visit.risksAndProtocols.culture);
    _infectionPreventionController = TextEditingController(
        text: visit.risksAndProtocols.infectionPrevention.others);
    _maintenanceJustificationController = TextEditingController(
        text: visit.risksAndProtocols.maintenanceJustification);
    _useATBController =
        TextEditingController(text: visit.risksAndProtocols.atbUse.atb);
    _useATBDaysController =
        TextEditingController(text: visit.risksAndProtocols.atbUse.days);
    _vomitingController =
        TextEditingController(text: visit.risksAndProtocols.vomiting.which);
    _evacuationController =
        TextEditingController(text: visit.risksAndProtocols.evacuation.which);
    _diuresisVolumeRiskController =
        TextEditingController(text: visit.risksAndProtocols.diuresis.volume);
    _diuresisCharacteristicsRiskController = TextEditingController(
        text: visit.risksAndProtocols.diuresis.characteristics);
    _drainsTypesController =
        TextEditingController(text: visit.diet.drains.types);
    _drainsVolumeController =
        TextEditingController(text: visit.diet.drains.volume);
    _operativeWoundsLocalController =
        TextEditingController(text: visit.operativeWoundsLocal);
    _pendenciesController =
        TextEditingController(text: visit.pendencies.pendency);
    _lastVisitGoalController =
        TextEditingController(text: visit.pendencies.lastVisitGoal);
    _examsProceduresEvaluationsController = TextEditingController(
        text: visit.pendencies.examsProceduresEvaluations);
    _nighRoundController = TextEditingController(text: visit.nightRound);
    _goal1Controller = TextEditingController(text: visit.goals.goal1);
    _goal2Controller = TextEditingController(text: visit.goals.goal2);
    _goal3Controller = TextEditingController(text: visit.goals.goal3);
    _goal4Controller = TextEditingController(text: visit.goals.goal4);
    _goal5Controller = TextEditingController(text: visit.goals.goal5);
    _participantsController = TextEditingController(text: visit.participants);
  }

  bool isEditable() {
    return visit.id == null;
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
}
