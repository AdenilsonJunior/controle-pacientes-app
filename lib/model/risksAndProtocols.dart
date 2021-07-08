import 'package:controle_pacientes/model/diuresis.dart';
import 'package:controle_pacientes/model/hasWhich.dart';
import 'package:controle_pacientes/model/tevProtocol.dart';
import 'package:controle_pacientes/util/listUtil.dart';

import 'atbUse.dart';

class RisksAndProtocols {
  HasWhich woundSkinRisk;
  HasWhich bronchoaspiration;
  HasWhich gastricProtection;
  OptionOthers tevProtocol;
  String culture;
  OptionOthers infectionPrevention;
  String maintenanceJustification;
  ATBUse atbUse;
  List<String> precaution;
  String analgesia;
  HasWhich vomiting;
  HasWhich evacuation;
  Diuresis diuresis;

  Map<dynamic, dynamic> toJson() {
    return {
      'woundSkinRisk': woundSkinRisk.toJson(),
      'bronchoaspiration': bronchoaspiration.toJson(),
      'gastricProtection': gastricProtection.toJson(),
      'tevProtocol': tevProtocol.toJson(),
      'culture': culture,
      'infectionPrevention': infectionPrevention.toJson(),
      'maintenanceJustification': maintenanceJustification,
      'atbUse': atbUse.toJson(),
      'precaution': precaution,
      'analgesia': analgesia,
      'vomiting': vomiting.toJson(),
      'evacuation': evacuation.toJson(),
      'diuresis': diuresis.toJson()
    };
  }

  RisksAndProtocols(Map<dynamic, dynamic> json) {
    this.woundSkinRisk = HasWhich.parse(json['woundSkinRisk']);
    this.bronchoaspiration = HasWhich.parse(json['bronchoaspiration']);
    this.gastricProtection = HasWhich.parse(json['gastricProtection']);
    this.tevProtocol = OptionOthers.parse(json['tevProtocol']);
    this.culture = json['culture'];
    this.infectionPrevention = OptionOthers.parse(json['infectionPrevention']);
    this.maintenanceJustification = json['maintenanceJustification'];
    this.atbUse = ATBUse.parse(json['atbUse']);
    this.precaution = ListUtil.parseToListString(json['precaution']);
    this.analgesia = json['analgesia'];
    this.vomiting = HasWhich.parse(json['vomiting']);
    this.evacuation = HasWhich.parse(json['evacuation']);
    this.diuresis = Diuresis.parse(json['diuresis']);
   //DEPOIS DISSO QUEBRANDO AINDA, DEBUGAR
  }

  static RisksAndProtocols parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      return RisksAndProtocols.newInstance();
    } else {
      return RisksAndProtocols(json);
    }
  }

  RisksAndProtocols.newInstance() {
    this.woundSkinRisk = HasWhich.newInstance();
    this.bronchoaspiration = HasWhich.newInstance();
    this.gastricProtection = HasWhich.newInstance();
    this.tevProtocol = OptionOthers.newInstance();
    this.culture = "";
    this.infectionPrevention = OptionOthers.newInstance();
    this.maintenanceJustification = "";
    this.atbUse = ATBUse.newInstance();
    this.precaution = [];
    this.analgesia = "";
    this.vomiting = HasWhich.newInstance();
    this.evacuation = HasWhich.newInstance();
    this.diuresis = Diuresis.newInstance();
  }
}