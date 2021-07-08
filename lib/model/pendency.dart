class Pendency {
  String pendency;
  String lastVisitGoal;
  String examsProceduresEvaluations;

  Pendency(Map<dynamic, dynamic> json) {
    this.pendency = json['pendency'];
    this.lastVisitGoal = json['lastVisitGoal'];
    this.examsProceduresEvaluations = json ['examsProceduresEvaluations'];
  }

  static Pendency parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      return Pendency.newInstance();
    } else {
      return Pendency(json);
    }
  }

  Pendency.newInstance();

  Map<dynamic, dynamic> toJson() {
    return {
      'pendency': this.pendency,
      'lastVisitGoal': this.lastVisitGoal,
      'examsProceduresEvaluations': this.examsProceduresEvaluations
    };
  }
}