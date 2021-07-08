import 'package:controle_pacientes/model/patient.dart';
import 'package:controle_pacientes/model/section.dart';
import 'package:controle_pacientes/repository/patientRepository.dart';
import 'package:controle_pacientes/util/formatterUtil.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddPatientScreen extends StatelessWidget {
  Section _section;

  PatientRepository _repository = PatientRepository();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _hospitalBedController = TextEditingController();
  TextEditingController _doctorController = TextEditingController();
  TextEditingController _dietController = TextEditingController();
  TextEditingController _entryController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();

  MaskTextInputFormatter _cpfFormatter = FormatterUtil.getCPFFormatter();
  MaskTextInputFormatter _timeFormatter = FormatterUtil.getTimeFormatter();

  AddPatientScreen(this._section);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Adicionar Paciente", style: TextStyle(color: Colors.white)),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Deseja salvar este paciente?"),
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
                              Patient patient = getPatient();
                              String result = await _repository.addPatient(patient);
                              if(result ==  "Success") {
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
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(
                    _nameController,
                    "Nome:",
                    align: TextAlign.start,
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(
                    _cpfController,
                    "CPF:",
                    inputType: TextInputType.number,
                    align: TextAlign.start,
                    formatter: _cpfFormatter,
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(_ageController, "Idade:",
                      inputType: TextInputType.number, align: TextAlign.start),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(_hospitalBedController, "Leito:",
                      align: TextAlign.start),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(
                    _doctorController,
                    "Médico:",
                    align: TextAlign.start,
                    isUpperCase: true,
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(
                    _dietController,
                    "Dieta:",
                    align: TextAlign.start,
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: RowInputValue(
                    _entryController,
                    "Entrada:",
                    align: TextAlign.start,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.done,
                    formatter: _timeFormatter,
                  ),
                ))
              ],
            )
          ],
        ),
      ),
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

  Patient getPatient() {
    return Patient.newInstance(
        _nameController.text,
        _ageController.text,
        _hospitalBedController.text,
        _entryController.text,
        _dietController.text,
        _doctorController.text,
        _cpfFormatter.getUnmaskedText(),
        _section.id);
  }
}
