class ATBUse {
  String atb;
  String days;

  ATBUse(Map<dynamic, dynamic> json) {
    this.atb = json['atb'];
    this.days = json['days'];
  }

  static ATBUse parse(Map<dynamic, dynamic> json) {
    if (json != null) {
      return ATBUse(json);
    } else {
      return ATBUse.newInstance();
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'atb': this.atb,
      'days': this.days
    };
  }

  ATBUse.newInstance();
}