import 'package:controle_pacientes/model/multidisciplinaryVisit.dart';
import 'package:controle_pacientes/model/patient.dart';

class TherapeuticPlanning {
  String id;
  Patient patient;
  String attendance;
  String admissionDate;
  String admissionDateHospital;
  String hospitalizationReason;
  String comorbidities;
  String responsible;
  List<MultidisciplinaryVisit> multidisciplinaryVisit;
  bool isFinished = false;
  int createdAt;

  TherapeuticPlanning(Map<dynamic, dynamic> json) {
    this.id = json['id'];
    this.attendance = json['attendance'];
    this.admissionDate = json['admissionDate'];
    this.admissionDateHospital = json['admissionDateHospital'];
    this.hospitalizationReason = json['hospitalizationReason'];
    this.comorbidities = json['comorbidities'];
    this.patient = Patient(json['patient']);
    this.responsible = json['responsible'];
    this.multidisciplinaryVisit =
        parseMultidisciplinaryVisits(json['multidisciplinaryVisit']);
    bool finished = json['isFinished'];
    this.isFinished = finished != null && finished;
    this.createdAt = json['createdAt'];
  }

  TherapeuticPlanning.newInstance();

  List<MultidisciplinaryVisit> parseMultidisciplinaryVisits(
      Map<dynamic, dynamic> visits) {
    var list = List<MultidisciplinaryVisit>.empty(growable: true);
    if (visits != null) {
      visits.forEach((key, value) {
        list.add(MultidisciplinaryVisit(value));
      });
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendance': attendance,
      'admissionDate': admissionDate,
      'admissionDateHospital': admissionDateHospital,
      'hospitalizationReason': hospitalizationReason,
      'comorbidities': comorbidities,
      'isFinished': isFinished,
      'responsible': responsible,
      'createdAt': createdAt,
      'patient': patient.toJson(),
      'multidisciplinaryVisit': getVisits()
    };
  }

  Map<dynamic, dynamic> getVisits() {
    if(multidisciplinaryVisit != null && multidisciplinaryVisit.isNotEmpty) {
      return Map.fromIterable(multidisciplinaryVisit, key: (v) => (v as MultidisciplinaryVisit).id, value: (v) => (v as MultidisciplinaryVisit).toJson());
    } else {
      return null;
    }
  }
}
