import 'package:controle_pacientes/database/firebaseDatabaseHelper.dart';
import 'package:controle_pacientes/model/patient.dart';
import 'package:controle_pacientes/model/section.dart';

class PatientRepository {
  Future<List<Patient>> getPatients(Section section) async {
    var snapshot = await FirebaseDatabaseHelper.getPatients(section);
    var list = (snapshot.value as Map<dynamic, dynamic>)
        .values
        .map((e) => Patient(e as Map<dynamic, dynamic>))
        .toList();

    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  Future<String> addPatient(Patient patient) async {

    if(patient.name.isEmpty || patient.name.length < 2) {
      return Future.value("Nome inválido");
    }

    if(patient.cpf.isEmpty || patient.cpf.length != 11) {
      return Future.value("CPF inválido");
    }

    if(patient.age.isEmpty) {
      return Future.value("Idade inválida");
    }

    if(patient.hospitalBed.isEmpty) {
      return Future.value("Leito inválido");
    }

    if(patient.doctor.isEmpty) {
      return Future.value("Médico inválido");
    }

    if(patient.lastDiet.isEmpty) {
      patient.lastDiet = "-";
    }

    if(patient.entry.isEmpty || patient.entry.length != 5) {
      return Future.value("Horário de entrada inválido");
    }

    await FirebaseDatabaseHelper.addPatient(patient);

    return Future.value("Success");
  }

  void removePatient(Patient patient) {
    FirebaseDatabaseHelper.removePatient(patient);
  }
}
