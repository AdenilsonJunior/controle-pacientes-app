import 'package:controle_pacientes/database/firebaseDatabaseHelper.dart';
import 'package:controle_pacientes/model/multidisciplinaryVisit.dart';
import 'package:controle_pacientes/model/patient.dart';
import 'package:controle_pacientes/model/therapeuticPlanning.dart';
import 'package:controle_pacientes/util/dateUtil.dart';

class TherapeuticPlanningRepository {
  Future<List<TherapeuticPlanning>> getTherapeuticPlanningsByPatient(
      Patient patient) async {
    var dataSnapshot =
        await FirebaseDatabaseHelper.getTherapeuticPlanningsByPatient(patient);
    var plannings = (dataSnapshot.value as Map<dynamic, dynamic>)
        .values
        .map((e) => TherapeuticPlanning(e))
        .toList();

    plannings.sort((a, b) => -a.createdAt.compareTo(b.createdAt));

    return plannings;
  }

  Future<TherapeuticPlanning> getTherapeuticPlanning(
      TherapeuticPlanning planning) async {
    var dataSnapshot =
        await FirebaseDatabaseHelper.getTherapeuticPlanning(planning);
    var requestPlanning =
        TherapeuticPlanning(dataSnapshot.value as Map<dynamic, dynamic>);

    requestPlanning.multidisciplinaryVisit
        .sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return requestPlanning;
  }

  Future<String> saveTherapeuticPlanning(TherapeuticPlanning planning) async {
    if (planning.admissionDate.length != 10 &&
        planning.admissionDate.length != 0) {
      return Future.value("Data de admissão inválida");
    }

    if (planning.admissionDateHospital.length != 10 &&
        planning.admissionDateHospital.length != 0) {
      return Future.value("Data de admissão na unidade inválida");
    }

    if (planning.responsible.isEmpty || planning.responsible.length < 2) {
      return Future.value("Nome do responsável inválido");
    }

    await FirebaseDatabaseHelper.saveTherapeuticPlanning(planning);
    return Future.value("Success");
  }

  Future<String> saveVisit(
      TherapeuticPlanning planning, MultidisciplinaryVisit visit) async {
    if (visit.responsible == null ||
        visit.responsible.isEmpty ||
        visit.responsible.length < 2) {
      return Future.value("Nome do responsável inválido");
    }

    if (visit.clinicalEvolution.complications.has == null) {
      return Future.value("Campo INTERCORRÊNCIAS obrigatório");
    }

    if (visit.clinicalEvolution.diuresis.volume == null ||
        visit.clinicalEvolution.diuresis.volume.isEmpty ||
        visit.clinicalEvolution.diuresis.characteristics == null ||
        visit.clinicalEvolution.diuresis.characteristics.isEmpty) {
      return Future.value("Campo DIURESE obrigatório");
    }

    if (visit.clinicalEvolution.evacuation == null) {
      return Future.value("Campo EVACUAÇÃO obrigatório");
    }

    if (visit.risksAndProtocols.tevProtocol.options.isEmpty &&
        (visit.risksAndProtocols.tevProtocol.others == null ||
            visit.risksAndProtocols.tevProtocol.others.isEmpty)) {
      return Future.value("Campo PROTOCOLO TEV obrigatório");
    }

    if (visit.risksAndProtocols.atbUse.atb == null ||
        visit.risksAndProtocols.atbUse.atb.isEmpty ||
        visit.risksAndProtocols.atbUse.days == null ||
        visit.risksAndProtocols.atbUse.days.isEmpty) {
      return Future.value("Campo USO ATB obrigatório");
    }

    if (visit.risksAndProtocols.vomiting.has == null) {
      return Future.value("Campo VÔMITO obrigatório");
    }

    if (visit.diet.diet == null || visit.diet.diet.isEmpty) {
      return Future.value("Campo DIETA obrigatório");
    }

    if (visit.diet.drains.volume == null ||
        visit.diet.drains.volume.isEmpty ||
        visit.diet.drains.types == null ||
        visit.diet.drains.types.isEmpty) {
      return Future.value("Campo DRENOS obrigatório");
    }

    if (visit.operativeWoundsLocal == null ||
        visit.operativeWoundsLocal.isEmpty) {
      return Future.value("Campo FERIDAS OPERATÓRIAS obrigatório");
    }

    await FirebaseDatabaseHelper.saveVisit(planning, visit);
    return Future.value("Success");
  }

  Future<void> finishTherapeuticPlanning(TherapeuticPlanning planning) async {
    planning.isFinished = true;
    await FirebaseDatabaseHelper.saveTherapeuticPlanning(planning);

    String title = "Atendimento finalizado";
    String hour = DateUtil.getCurrentTime(DateTime.now());
    String message = "Atendimento de " +
        planning.patient.name +
        " foi encerrado às " +
        hour.toString() +
        ". LEITO: " +
        planning.patient.hospitalBed;

    FirebaseDatabaseHelper.sendNotification(
        title, message, planning.patient.sectionId);
  }

  Future<TherapeuticPlanning> createTherapeuticPlanning(Patient patient) async {
    return await FirebaseDatabaseHelper.createTherapeuticPlanning(patient);
  }

  Future<void> removeTherapeuticPlanning(TherapeuticPlanning planning) async {
    await FirebaseDatabaseHelper.removeTherapeuticPlanning(planning);
  }

  Future<void> removeVisit(
      TherapeuticPlanning planning, MultidisciplinaryVisit visit) async {
    await FirebaseDatabaseHelper.removeVisit(planning, visit);
  }
}
