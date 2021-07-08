class Patient {
  String name;
  String age;
  String hospitalBed;
  String entry;
  String lastDiet;
  String doctor;
  String cpf;
  String sectionId;

  Patient(Map<dynamic, dynamic> json) {
    this.name = json['name'];
    this.age = json['age'];
    this.hospitalBed = json['hospitalBed'];
    this.entry = json['entry'];
    this.lastDiet = json['lastDiet'];
    this.doctor = json['doctor'];
    this.cpf = json['cpf'];
    this.sectionId = json['sectionId'];
  }

  Patient.newInstance(this.name, this.age, this.hospitalBed, this.entry,
      this.lastDiet, this.doctor, this.cpf, this.sectionId);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'hospitalBed': hospitalBed,
      'entry': entry,
      'lastDiet': lastDiet,
      'doctor': doctor,
      'cpf': cpf,
      'sectionId': sectionId
    };
  }
}
