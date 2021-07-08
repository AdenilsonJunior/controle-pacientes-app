import 'package:controle_pacientes/util/listUtil.dart';

import 'hasWhich.dart';
import 'diuresis.dart';

class ClinicalEvolution {
  HasWhich complications;
  HasWhich vitalSignalChanges;
  String glycemicControl;
  Diuresis diuresis;
  String evacuation;
  HasWhich laboratoryTests;
  List<String> imageTests;

  ClinicalEvolution(Map<dynamic, dynamic> json) {
    this.complications = HasWhich.parse(json['complications']);
    this.vitalSignalChanges = HasWhich.parse(json['vitalSignalChanges']);
    this.glycemicControl = json['glycemicControl'];
    this.diuresis = Diuresis(json['diuresis']);
    this.evacuation = json['evacuation'];
    this.laboratoryTests = HasWhich.parse(json['laboratoryTests']);
    this.imageTests = ListUtil.parseToListString(json['imageTests']);
  }

  static ClinicalEvolution parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      return ClinicalEvolution.newInstance();
    } else {
      return ClinicalEvolution(json);
    }
  }

  ClinicalEvolution.newInstance() {
    this.complications = HasWhich.newInstance();
    this.vitalSignalChanges = HasWhich.newInstance();
    this.diuresis = Diuresis.newInstance();
    this.laboratoryTests = HasWhich.newInstance();
    this.imageTests = [];
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'complications': this.complications.toJson(),
      'vitalSignalChanges': this.vitalSignalChanges.toJson(),
      'glycemicControl': this.glycemicControl,
      'diuresis': this.diuresis.toJson(),
      'evacuation': this.evacuation,
      'laboratoryTests': this.laboratoryTests.toJson(),
      'imageTests': this.imageTests
    };
  }
}
