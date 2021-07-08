class Goals {
  String goal1;
  String goal2;
  String goal3;
  String goal4;
  String goal5;

  Goals(Map<dynamic, dynamic> json) {
    this.goal1 = json['goal1'];
    this.goal2 = json['goal2'];
    this.goal3 = json['goal3'];
    this.goal4 = json['goal4'];
    this.goal5 = json['goal5'];
  }

  Goals.newInstance();

  static Goals parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      Goals.newInstance();
    } else {
      return Goals(json);
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'goal1': this.goal1,
      'goal2': this.goal2,
      'goal3': this.goal3,
      'goal4': this.goal4,
      'goal5': this.goal5
    };
  }
}