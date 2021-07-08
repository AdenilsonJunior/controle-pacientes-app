import 'package:controle_pacientes/model/patient.dart';

class Section {
  String id;
  String name;
  String date;
  int timestamp;
  String responsible;
  String time;
  List<Patient> patients;

  Section(Map<dynamic, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.date = json['date'];
    this.time = json['time'];
    this.responsible = json['responsible'];
    this.timestamp = json['timestamp'];
    this.patients = parseJsonPatients(json['patients'] as Map<dynamic, dynamic>);
  }

  List<Patient> parseJsonPatients(Map<dynamic, dynamic> json) {
    if(json != null) {
      return json.values.map((e) => Patient(e)).toList();
    } else {
      return [];
    }
  }

  Section.newInstance(this.name, this.date, this.responsible, this.timestamp, this.time) {
    this.id = this.name + " " + this.date;
    this.patients = [];
  }

  Map<dynamic, dynamic> toJson() {
    return  {
      'id': id,
      'name': name,
      'date': date,
      'time': time,
      'responsible': responsible,
      'timestamp': timestamp,
      'patients': []
    };
  }
}