import 'package:controle_pacientes/model/drain.dart';
import 'package:controle_pacientes/util/listUtil.dart';

class Diet {
  List<String> diet;
  Drain drains;

  Diet(Map<dynamic, dynamic> json) {
    this.diet = ListUtil.parseToListString(json['diet']);
    this.drains = Drain.parse(json['drains']);
  }

  static Diet parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      return Diet.newInstance();
    } else {
      return Diet(json);
    }
  }

  Diet.newInstance() {
    this.diet = [];
    this.drains = Drain.newInstance();
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'diet': this.diet,
      'drains': this.drains.toJson()
    };
  }
}