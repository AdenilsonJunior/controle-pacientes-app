import 'package:controle_pacientes/login/loginScreen.dart';
import 'package:controle_pacientes/model/currentUser.dart';
import 'package:controle_pacientes/model/section.dart';
import 'package:controle_pacientes/model/sectionVM.dart';
import 'package:controle_pacientes/patientList/patientListScreen.dart';
import 'package:controle_pacientes/repository/sectionRepository.dart';
import 'package:controle_pacientes/repository/userRepository.dart';
import 'package:controle_pacientes/util/formatterUtil.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:controle_pacientes/view/sectionCard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SectionListScreen extends StatefulWidget {
  @override
  _SectionListScreenState createState() => _SectionListScreenState();
}

class _SectionListScreenState extends State<SectionListScreen> {
  final SectionRepository _repository = SectionRepository();
  final UserRepository _workerRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      UserRepository().saveToken(token);
    });

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Copas",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _workerRepository.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                          (r) => false);
                },
                child: Text(
                  "SAIR",
                  style: TextStyle(color: Colors.white),
                ))
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAddSectionDialog(context);
        },
        label: Text("Inserir Copa", style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: _repository.getUserAndSections(),
          builder: (context, data) {
            if (data.hasData) {
              SectionVM sectionVM = data.data as SectionVM;
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 76.0),
                itemBuilder: (context, index) {
                  Section section = sectionVM.sections[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 16.0),
                      child: SectionCard(sectionVM.user.listenSections, section,
                              (Section section) {
                                showDeleteSectionDialog(context, section);
                          },
                          (String sectionId) {
                              _repository.listenUpdates(sectionVM.user, sectionId);
                              setState(() {});
                          }),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientListScreen(section))).then((value) {
                        setState(() {});
                      });
                    },
                  );
                },
                itemCount: sectionVM.sections.length,
                scrollDirection: Axis.vertical,
              );
            }

            if (data.hasError) {
              if (data.error is NoSuchMethodError) {
                return Center(
                    heightFactor: 5,
                    child: Text("Não existe copas cadastradas",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)));
              }
              return Text("Erro ao retornar as copas");
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  void showAddSectionDialog(BuildContext context) {
    TextEditingController _sectionNameController = TextEditingController();
    TextEditingController _sectionDateController = TextEditingController();
    TextEditingController _sectionTimeController = TextEditingController();
    MaskTextInputFormatter _dateFormatter = FormatterUtil.getDateFormatter();
    MaskTextInputFormatter _timeFormatter = FormatterUtil.getTimeFormatter();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adicionar Copa'),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RowInputValue(_sectionNameController, "Nome:",
                            isUpperCase: true,),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RowInputValue(
                            _sectionDateController,
                            "Data:",
                            formatter: _dateFormatter,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RowInputValue(
                            _sectionTimeController,
                            "Horário Atual:",
                            formatter: _timeFormatter,
                            inputAction: TextInputAction.done,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "CANCELAR", style: TextStyle(color: Colors.grey),)),
              TextButton(
                  onPressed: () async {
                    var success = await _repository.addSection(
                        _sectionNameController.text,
                        _sectionDateController.text,
                        _sectionTimeController.text);
                    if (success) {
                      Navigator.pop(context);
                      setState(() {});
                    } else {
                      showErrorDialog(context);
                    }
                  },
                  child: Text(
                    'CONCLUIR',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          );
        });
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Erro"),
              content: Text("Não foi possível adicionar uma nova copa"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
  }

  void showDeleteSectionDialog(BuildContext context, Section section) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Atenção'),
        content: Text('Tem certeza que deseja remover esta copa?'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('NÃO', style: TextStyle(color: Colors.grey[600]),)),
          TextButton(onPressed: () {
            Navigator.pop(context);
            _repository.removeSection(section);
            setState(() {});
          }, child: Text('SIM', style: TextStyle(color: Colors.blue),))
        ],
      );
    });
  }
}