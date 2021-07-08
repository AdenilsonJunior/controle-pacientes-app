import 'package:controle_pacientes/util/listUtil.dart';

class OptionOthers {
  List<String> options;
  String others;

  OptionOthers(Map<dynamic, dynamic> json) {
    this.options = ListUtil.parseToListString(json['options']);
    this.others = json['others'];
  }

  static OptionOthers parse(Map<dynamic, dynamic> json) {
    if (json != null) {
      return OptionOthers(json);
    } else {
      return OptionOthers.newInstance();
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'options': this.options,
      'others': this.others
    };
  }

  OptionOthers.newInstance() {
    this.options = [];
  }
}