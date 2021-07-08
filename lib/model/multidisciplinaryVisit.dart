import 'package:controle_pacientes/model/diet.dart';
import 'package:controle_pacientes/model/pendency.dart';

import 'clinicalEvolution.dart';
import 'goals.dart';
import 'risksAndProtocols.dart';

class MultidisciplinaryVisit {
  String id;
  String date;
  int createdAt;
  String responsible;
  ClinicalEvolution clinicalEvolution;
  RisksAndProtocols risksAndProtocols;
  Diet diet;
  String operativeWoundsLocal;
  String physiotherapy;
  Pendency pendencies;
  String nightRound;
  Goals goals;
  String participants;

  Map<dynamic, dynamic> toJson() {
    return {
      'id': this.id,
      'date': this.date,
      'responsible': this.responsible,
      'clinicalEvolution': this.clinicalEvolution.toJson(),
      'risksAndProtocols': this.risksAndProtocols.toJson(),
      'diet': this.diet.toJson(),
      'operativeWoundsLocal': this.operativeWoundsLocal,
      'physiotherapy': this.physiotherapy,
      'pendencies': this.pendencies.toJson(),
      'nightRound': this.nightRound,
      'goals': this.goals.toJson(),
      'participants': this.participants,
      'createdAt': this.createdAt
    };
  }

  MultidisciplinaryVisit(Map<dynamic, dynamic> json) {
    this.id = json['id'];
    this.date = json['date'];
    this.responsible = json['responsible'];
    this.clinicalEvolution = ClinicalEvolution.parse(json['clinicalEvolution']);
    this.risksAndProtocols = RisksAndProtocols.parse(json['risksAndProtocols']);
    this.diet = Diet.parse(json['diet']);
    this.operativeWoundsLocal = json['operativeWoundsLocal'];
    this.physiotherapy = json['physiotherapy'];
    this.pendencies = Pendency.parse(json['pendencies']);
    this.nightRound = json['nightRound'];
    this.goals = Goals.parse(json['goals']);
    this.participants = json['participants'];
    this.createdAt = json['createdAt'];
  }

  MultidisciplinaryVisit.newInstance() {
    this.clinicalEvolution = ClinicalEvolution.newInstance();
    this.risksAndProtocols = RisksAndProtocols.newInstance();
    this.diet = Diet.newInstance();
    this.pendencies = Pendency.newInstance();
    this.goals = Goals.newInstance();
  }
}
