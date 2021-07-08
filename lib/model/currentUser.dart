import 'package:controle_pacientes/util/listUtil.dart';

class CurrentUser {
  String uid;
  String name;
  String cpf;
  String email;
  String pushToken;
  List<String> listenSections;

  CurrentUser(this.uid, this.name, this.cpf, this.email, this.pushToken);

  CurrentUser.fromJson(Map<dynamic, dynamic> json) {
    this.uid = json['uid'];
    this.name = json['name'];
    this.cpf = json['cpf'];
    this.email = json['email'];
    this.pushToken = json['pushToken'];
    this.listenSections = ListUtil.parseToListString(json['listenSections']);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'uid': this.uid,
      'name': this.name,
      'cpf': this.cpf,
      'email': this.email,
      'pushToken': this.pushToken,
      'listenSections': this.listenSections
    };
  }
}
